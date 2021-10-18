/*
 * package com.teamproject.StudentCommunity.dto;
 * 
 * 
 * import javax.validation.constraints.NotBlank; import
 * javax.validation.constraints.NotNull; import
 * javax.validation.constraints.Pattern; import
 * javax.validation.constraints.Positive; import
 * javax.validation.constraints.Size;
 * 
 * import lombok.Getter; import lombok.Setter;
 * 
 * @Getter
 * 
 * @Setter public class MemberDTO {
 * 
 * private Long id;
 * 
 * //@NotBlank(message = "메일을 작성해주세요.")
 * 
 * @NotBlank(message="이메일을 입력해주세요.")
 * 
 * @Size(min=5, message="이메일 형식이 아닙니다.")
 * 
 * @Pattern(regexp="^[a-zA-Z0-9]*$",message="메일의 양식을 지켜주세요.") private String
 * email;
 * 
 * @Pattern(regexp = "^01([0|1|6|7|8|9])-?([0-9]{3,4})-?([0-9]{4})$" ,message =
 * "01(?)-xxxx-xxxx") private String phoneNo;
 * 
 * @NotBlank(message = "닉네임을 작성해주세요.")
 * 
 * @Pattern(regexp = "^[ㄱ-ㅎ|가-힣|a-z|A-Z|0-9|\\*]{2,8}$" ,message =
 * "사용하실 수 없는 닉네임 입니다. (2글자 ~ 8글자)") private String name;
 * 
 * @NotBlank(message="비밀번호를 입력해주세요")
 * 
 * @Pattern(regexp="^(?=.*[a-zA-Z])(?=.*[~!@#$%^*+=-])(?=.*[0-9]).{8,16}$",
 * message="숫자+영문자+특수문자 조합으로 8자리 이상 사용해야 합니다.(최대 16글자)") private String
 * password;
 * 
 * 
 * @NotBlank(message="비밀번호를 입력해주세요")
 * 
 * @Pattern(regexp="^(?=.*[a-zA-Z])(?=.*[~!@#$%^*+=-])(?=.*[0-9]).{8,16}$",
 * message="숫자+영문자+특수문자 조합으로 8자리 이상 사용해야 합니다.(최대 16글자)")
 * 
 * private String password2; // db x
 * 
 * private String img;
 * 
 * // 정지회원인지 구분 private MemberStatus status;
 * 
 * @Positive(message="이메일 인증을 해주세요") private String emailAuth;
 * 
 * private String universityId;
 * 
 * private String domain; // db x
 * 
 * private boolean checkUser; // db x
 * 
 * private boolean userLogin; // db x
 * 
 * private String universityName;
 * 
 * 
 * 
 * 
 * 
 * 
 * 
 * public MemberDTO() { this.userLogin = false; }
 * 
 * 
 * 
 * 
 * }
 */











package com.teamproject.StudentCommunity.dto;


import javax.validation.constraints.*;

import com.teamproject.StudentCommunity.dto.board.BoardCategoryDto;
import lombok.Data;
import lombok.Getter;
import lombok.Setter;

import java.util.List;

@Data
public class MemberDTO {
	
	private Long id;

	//@NotBlank(message = "메일을 작성해주세요.")
	@NotBlank(message="이메일을 입력해주세요.")
	@Size(min=5, message="이메일 형식이 아닙니다.")
    @Pattern(regexp="^[a-zA-Z0-9]*$",message="메일의 양식을 지켜주세요.")
    private String email;

	
	@NotBlank(message = "닉네임을 작성해주세요.")
	@Pattern(regexp = "^[ㄱ-ㅎ|가-힣|a-z|A-Z|0-9|\\*]{2,8}$" ,message = "사용하실 수 없는 닉네임 입니다. (2글자 ~ 8글자)")
	private String name;
	
	@NotBlank(message="비밀번호를 입력해주세요")
	@Pattern(regexp="^(?=.*[a-zA-Z])(?=.*[~!@#$%^*+=-])(?=.*[0-9]).{8,16}$",message="숫자+영문자+특수문자 조합으로 8자리 이상 사용해야 합니다.(최대 16글자)")
	private String password;
	

	@NotBlank(message="비밀번호를 입력해주세요")
	@Pattern(regexp="^(?=.*[a-zA-Z])(?=.*[~!@#$%^*+=-])(?=.*[0-9]).{8,16}$",message="숫자+영문자+특수문자 조합으로 8자리 이상 사용해야 합니다.(최대 16글자)")

	private String password2; // db x
	private String img;
	
	// 정지회원인지 구분
	private MemberStatus status;
	
	@Positive(message="이메일 인증을 해주세요")
	private String emailAuth;
	
	private Long universityId;
	
	private String domain; // db x

	@AssertTrue(message="닉네임 중복확인을 해주세요")
	private boolean checkUser; // db x

	private boolean userLogin; // db x

	private List<BoardCategoryDto> boardList;
	
	private String universityName;

	public MemberDTO() {
		this.userLogin = false;
	}
	
	
	
	
}













