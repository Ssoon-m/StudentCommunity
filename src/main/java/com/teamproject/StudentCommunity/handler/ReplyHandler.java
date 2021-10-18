package com.teamproject.StudentCommunity.handler;

import com.mysql.cj.util.StringUtils;
import com.teamproject.StudentCommunity.dto.MemberDTO;
import org.springframework.security.core.userdetails.User;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class ReplyHandler extends TextWebSocketHandler {

    // sessions에는 모든 유저가 들어있다.
    List<WebSocketSession> sessions = new ArrayList<>();
    // id(string)를 가지고 map에 담는다.
    Map<String, WebSocketSession> userSessions = new HashMap<>();

    // 클라이언트가 서버에 접속이 성공 했을때마다 탄다.
    @Override
    public void afterConnectionEstablished(WebSocketSession session) throws Exception{
        System.out.println("afterConnectionEstablished : " + session);
        sessions.add(session); // 현재 접속된 유저들은 전부 이 안에 들어간다.

        String senderId = getId(session);
        userSessions.put(senderId, session); // 연결된 사용자에 해당되는 id가 들어간다.
    }

    // 클라이언트가 소켓에다가 메세지를 보냈을 때
    // 로그인한 사용자는 WebSocketSession이 아니라 httpSession에 있다.
    @Override
    protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception{
        System.out.println("handleTextMessage:" + session + " : " + message);
        // 메세지를 받은걸 접속되어있는 모두에게 보내준다. broad casting(송신 호스트가 전송한 데이터가 네트워크에 연결된 모든 호스트에게 전송되는 방식)

     //   String senderId = session.getId(); // session의 id 를 가져온다.
                                            // 예) 브라우저 2개 띄우면 서버에서 세션 2개 생성
//        for(WebSocketSession sess : sessions){
//            sess.sendMessage(new TextMessage(senderId + ": " + message.getPayload()));
//        }
        //JSON으로 하는게 가장 좋다.
        // protocol :  cmd, 댓글작성자, 게시글작성자,bno (ex: reply,user2,user1,234)
        String msg = message.getPayload();
        if(msg != null){
            String[] strs = msg.split(",");
            if(strs != null && strs.length == 5){
                String cmd = strs[0];
                String replyWriter = strs[1];
                String boardWriter = strs[2];
                String pno = strs[3];
                String bno = strs[4];
                userSessions.toString();
                // 게시글 작성자가 로그인 상태에만 알람이 오게 한다. get하면 webSocket session이 온다.
                WebSocketSession boardWriterSession = userSessions.get(boardWriter);
                if("reply".equals(cmd) && boardWriterSession != null){
                    System.out.println("reply들어왔는지?????");
                    TextMessage tmpMsg = new TextMessage(replyWriter + "님이" +"<a href='/board/"+bno+"/post/"+pno+"'>" + pno + "</a>번 게시글에 댓글을 달았습니다!");
                    boardWriterSession.sendMessage(tmpMsg); // 보내게 되면 자스 onMessage의 event파라미터가 받는다.
                }
                if("rereply".equals(cmd) && boardWriterSession != null){
                    System.out.println("reply들어왔는지?????");
                    TextMessage tmpMsg = new TextMessage(replyWriter + "님이 내 댓글에 댓글을 달았습니다!! " +"<a href='/board/"+bno+"/post/"+pno+"'>" + "[바로 이동]" + "</a>");
                    boardWriterSession.sendMessage(tmpMsg); // 보내게 되면 자스 onMessage의 event파라미터가 받는다.
                }


            }
        }
        String[] strs = message.getPayload().split(",");
    }

    private String getId(WebSocketSession session) {
        Map<String, Object> httpSession = session.getAttributes();

        // "login_id"로 바인딩된 객체가 없다면 null
        // login_id라는 key값으로
        //MemberDTO loginUser = (MemberDTO)session.getAttributes("loginMemberDTO");

        String loginUser = (String) httpSession.get("login_id");
        System.out.println("loginUser : " + loginUser);
     // User loginUser = (User) httpSession.get("login_id");


        if(null == loginUser){
            return session.getId(); // 로그인한 유저가 없다면 webSocket session의 id를 보낸다. (b61dfc0e-b30b-f730-b981-db0ec486ddde)
        }else{
            return loginUser; // 로그인한 유저가 있다면 http session을 보낸다. (tkksm@naver.com)
        }
    }
    // 커넥션이 종료 됐을 때

    @Override
    public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception{
        System.out.println("afterConnectionEstablished : " + session + " : " + status );
    }

}
