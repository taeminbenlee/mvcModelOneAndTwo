package filedown;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.PdsDao;
import dto.PdsDto;

public class FileDownLoader extends HttpServlet {
	
	ServletConfig mConfig = null;
	final int BUFFER_SIZE = 8192;
	
	@Override
	public void init(ServletConfig config) throws ServletException {
		mConfig = config;	// 업로드한 경로를 취득하기 위해서
	}

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		System.out.println("FileDownLoader doGet");
		
		String filename = req.getParameter("filename");
		int seq = Integer.parseInt( req.getParameter("seq") );
		
		PdsDao dao = PdsDao.getInstance();
		PdsDto dto = dao.getPds(seq);
		// dao -> down load 카운터 증가
		
		BufferedOutputStream out = new BufferedOutputStream(resp.getOutputStream());
		
		// path(경로)
		// tomcat - server
		String filepath = mConfig.getServletContext().getRealPath("/upload");
		
		// 폴더 - client
		// String filepath = "d:\\tmp";
		
		filepath = filepath + "\\" + filename;
		System.out.println("filepath:" + filepath);
		
		File f = new File(filepath);		
		
		if(f.exists() && f.canRead()) {
			
			// download window
		//	resp.setHeader("Content-Disposition", "attachment; filename=\"" + filename + "\";");
			// 셋헤더로 파일이름 정할때 원래이름을 넣어주면 원본명으로 다운된다.
			resp.setHeader("Content-Disposition","attachment; filename=\"" + dto.getFilename() + "\";");
			resp.setHeader("Content-Transfer-Encoding", "binary;");
	        resp.setHeader("Content-Length", "" + f.length());
	        resp.setHeader("Pragma", "no-cache;"); 
	        resp.setHeader("Expires", "-1;");
	        
	        // 파일 생성, 기입
	        BufferedInputStream fileInput = new BufferedInputStream(new FileInputStream(f));
	        
	        byte buffer[] = new byte[BUFFER_SIZE];	        
	        int read = 0; 
	        
	        while((read = fileInput.read(buffer)) != -1) {
	        	out.write(buffer, 0, read);		// 실제 다운로드        	
	        }
	        	        
	        fileInput.close();
	        out.flush();	        
		}
		
		/*
			1. 파일명 : 원본명 -> 변경 upload
			2. original filename, new filename
				- downcount++
			3. pdsdetail -> down load 기능
				- readcount++
			4. update
			5. delete
			
			6. (paging, search)
		
		*/
		
	}

	
}






