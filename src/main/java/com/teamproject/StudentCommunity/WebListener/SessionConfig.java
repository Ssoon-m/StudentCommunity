package com.teamproject.StudentCommunity.WebListener;

import javax.servlet.annotation.WebListener;
import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

// servlet-api 라이브러리를 가져와서 사용할 수 있는 애노테이션
@WebListener
public class SessionConfig implements HttpSessionListener {

    // 세션들 보관하는 Map, 모든 세션 보관
    private static final Map<String, HttpSession> sessions = new ConcurrentHashMap<>();

    //중복로그인 지우기
    public synchronized static String getSessionidCheck(String type, String compareId){
        String result = "";
        for( String key : sessions.keySet() ){ // KeySet은 key와value다 쓰기 위해
            HttpSession hs = sessions.get(key);
            if(hs != null &&  hs.getAttribute(type) != null && hs.getAttribute(type).toString().equals(compareId) ){
                result =  key.toString(); // 39EA08CA7DC7FBA54D0FCCBCE3A1E101
            }
        }
        removeSessionForDoubleLogin(result);
        // 해당 세션 지우고 넣어준다.
        return result;

    }

    // 세션이 곂칠경우 지워준다.
    private static void removeSessionForDoubleLogin(String userId){
        System.out.println("remove userId : " + userId);
        if(userId != null && userId.length() > 0){
            sessions.get(userId).invalidate();
            sessions.remove(userId);
        }
    }

    // 세션이 생성될때 동작한다.
    // 새션이 만들어지게 되면 에노테이션 WebListener에 의해서 세션값이 sessions에 저장
    @Override
    public void sessionCreated(HttpSessionEvent se) {
        sessions.put(se.getSession().getId(), se.getSession());
        System.out.println("se.getSession().getId() = " + se.getSession().getId()); // 11E60982CE6BFB9A47966366BED27301
        System.out.println("se.getSession() = " + se.getSession()); // org.apache.catalina.session.StandardSessionFacade@14025165
    }

    @Override
    public void sessionDestroyed(HttpSessionEvent se) {
        if(sessions.get(se.getSession().getId()) != null){
            sessions.get(se.getSession().getId()).invalidate();
            sessions.remove(se.getSession().getId());
        }
    }
}
