package com.teamproject.StudentCommunity.util;

import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

@Retention(RetentionPolicy.RUNTIME)
@Target(ElementType.METHOD)
public @interface UniversityBoardSession {
    enum Role {LOGIN,NOT_LOGIN}

    //@Auth(role=Role.ADMIN) 식으로 사용 가능능
    Role role();

}
