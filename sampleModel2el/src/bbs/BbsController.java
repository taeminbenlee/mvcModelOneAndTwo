package bbs;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.BbsDao;
import dto.BbsDto;
import dto.MemberDto;
import net.sf.json.JSONObject;

public class BbsController extends HttpServlet {
	
	
	
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doProcess(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doProcess(req, resp);
	}

	public void doProcess(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("utf-8");
		//확인용 문자열 
		System.out.println("bbsController doProcess");
		//param을 통해 거쳐갈 링크를 모두 설정.
		String param = req.getParameter("param");
	
		if (param.equals("board")) {
		
			BbsDao dao = BbsDao.getInstance();
			List<BbsDto> list = dao.getBbsList();
			
			req.setAttribute("bbslist", list);
			String destination = "bbslist.jsp";
			RequestDispatcher requestDispatcher = req.getRequestDispatcher(destination);
			
			requestDispatcher.forward(req, resp);
		}
		
		else if (param.equals("detail")) {
			int seq = Integer.parseInt(req.getParameter("seq").trim());
			
			BbsDao dao = BbsDao.getInstance();
			
			BbsDto dto = dao.getBBS(seq);
			
			req.setAttribute("detail", dto);
			req.setAttribute("content", "bbsdetail");
			forward("mainS.jsp", req, resp);	
			
		}
		else if(param.equals("bbslist")) {
			String choice = req.getParameter("choice");
			String search = req.getParameter("search");
			String spage = req.getParameter("pageNumber");
			int page = 0;
			if(spage != null && !spage.equals("")) {
				page = Integer.parseInt(spage);
			}
			if(choice == null) {
				choice = "";
			}
			if(search == null) {
				search = "";
			}
			
			BbsDao dao = BbsDao.getInstance();
			List<BbsDto> list = dao.getBbsPagingList(choice, search, page);
			req.getSession().setAttribute("list", list);
			
			int len = dao.getAllBbs(choice, search);
			int bbsPage = len / 10;		// 23 -> 2
			if((len % 10) > 0){
				bbsPage = bbsPage + 1;
			}
			req.setAttribute("bbsPage", bbsPage + "");
			req.setAttribute("pageNumber", page + "");
			
			req.setAttribute("content", "bbslist");
			
			forward("mainS.jsp", req, resp);	
			
		}		
		else if(param.equals("writeAf")) {
			String id = req.getParameter("id");
			String title = req.getParameter("title");
			String content = req.getParameter("content");

			System.out.println("id:" + id);
			System.out.println("title:" + title);
			System.out.println("content:" + content);

			BbsDao dao = BbsDao.getInstance();
			
			boolean isS = dao.writeBbs(new BbsDto(id, title, content));
			if(isS){
			
				resp.sendRedirect("bbs?param=bbslist");
			}else {
				
				resp.sendRedirect("bbswrite.jsp");
			}
			
		}
		else if(param.equals("delete")) {
			int seq = Integer.parseInt( req.getParameter("seq"));

			BbsDao dao = BbsDao.getInstance();
			boolean isD = dao.deleteBbs(seq);
			
			if(isD){
				resp.sendRedirect("bbs?param=bbslist");
			}else {
				resp.sendRedirect("bbs?param=bbslist");
			}
		}
		else if (param.equals("updateAf")) {
			int seq = Integer.parseInt( req.getParameter("seq"));

			String title = req.getParameter("title");
			String content = req.getParameter("content");

			BbsDao dao = BbsDao.getInstance();
			boolean isS = dao.updateBbs(seq, title, content);

			if(isS == true){
				System.out.println("글수정성공");
				resp.sendRedirect("bbs?param=bbslist");
			} else {
				System.out.println("글수정실패");
				resp.sendRedirect("bbs?param=bbslist");
			}
		}
		else if (param.equals("answerAf")) {
			int seq = Integer.parseInt(req.getParameter("seq").trim());
			String id = req.getParameter("id");
			String title = req.getParameter("title");
			String content = req.getParameter("content");

			System.out.println("seq: " + seq);
			System.out.println(id +" "+ title +" "+ content);
			BbsDao dao = BbsDao.getInstance();

			boolean isS = dao.answer(seq, new BbsDto(id, title, content));
			if(isS){
				System.out.println("답글작성성공");
				resp.sendRedirect("bbs?param=bbslist");
			} else {
				System.out.println("답글작성실패");
				resp.sendRedirect("bbs?param=bbslist");
			}
		}
		
		
		
		
		
		
		
		
		
		
	}
	public void forward(String arg, HttpServletRequest req, HttpServletResponse resp)throws ServletException, IOException {
		RequestDispatcher dispatch = req.getRequestDispatcher(arg);
		dispatch.forward(req, resp);			
	}
}
