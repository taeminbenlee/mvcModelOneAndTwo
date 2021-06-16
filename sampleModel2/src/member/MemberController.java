package member;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.SessionCookieConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.BbsDao;
import dao.MemberDao;
import dto.BbsDto;
import dto.MemberDto;
import net.sf.json.JSONObject;

public class MemberController extends HttpServlet{

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doProcess(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doProcess(req, resp);
	}
	//doProcess를 통해서 doGet이나 doPost를 상관없이 사용함
	public void doProcess(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		//확인용 문자열 
		System.out.println("MemberController doProcess");
		//param을 통해 거쳐갈 링크를 모두 설정.
		String param = req.getParameter("param");
		
		if(param.equals("login")) {
			resp.sendRedirect("login.jsp"); 
		}
		else if (param.equals("regi")) {
			resp.sendRedirect("regi.jsp");
		}
		//아이디 체크에선 파라미터가 id이다
		else if (param.equals("idcheck")) {
			String id = req.getParameter("id");
			System.out.println("id: " + id);
			
			//ID체크를 위해서 Dao를 통해서 DB로 날려줌
			MemberDao dao = MemberDao.getInstance();
			boolean b = dao.getId(id);
			//체크받은 데이터를 전송 YES or NO
			String str = "NO";
			if(b == false){	// id있음
				str="YES";
			}
			
			
			JSONObject jobj = new JSONObject();
			jobj.put("msg", str);
			
			resp.setContentType("application/x-json; charset=UTF-8");
			resp.getWriter().print(jobj);
			
		}
		else if (param.equals("accountCompt")) {
			
			String id = req.getParameter("id");
			String pwd = req.getParameter("pwd");
			String name = req.getParameter("name");
			String email = req.getParameter("email"); 

			System.out.println(id + " " + pwd + " " + name + " " + email);
			MemberDao dao = MemberDao.getInstance();

			MemberDto dto = new MemberDto(id, pwd, name, email, 0);
			boolean b = dao.addMember(dto);
			// 그냥 이동해 줘도 되지만, 확인을 원할 경우
						String msg = "OK";
						if(b == false) {
							msg = "NO";
						}
						
						resp.sendRedirect("Message.jsp?msg=" + msg);		
			
			
		}
		else if (param.equals("loginAf")) {
			System.out.println("MemberController loginAf");
			MemberDao dao = MemberDao.getInstance();
			String id = req.getParameter("id");
			String pwd = req.getParameter("pwd");
			
			MemberDto dto = dao.login(new MemberDto(id, pwd, null, null, 0));

			if(dto != null && !dto.getId().equals("")){
				req.getSession().setAttribute("login", dto);
				String msg = "welcome";
				resp.sendRedirect("mainS.jsp");
			} else {
				resp.sendRedirect("login.jsp");
			}
			
		}

		
	}
}
