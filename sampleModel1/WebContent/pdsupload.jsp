<%@page import="java.util.Date"%>
<%@page import="dto.PdsDto"%>
<%@page import="dao.PdsDao"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>
<%@page import="org.apache.commons.fileupload.disk.DiskFileItemFactory"%>
<%@page import="org.apache.commons.fileupload.servlet.ServletFileUpload"%>
<%@page import="java.io.File"%>
<%@page import="java.io.IOException"%>
<%@page import="org.apache.commons.fileupload.FileItem"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%!
// upload 함수
public String processUploadFile(FileItem fileItem, String newfilename, String dir)throws IOException{

	String filename = fileItem.getName();	// 경로 + 파일명
	long sizeInBytes = fileItem.getSize();
	
	if(sizeInBytes > 0){	// 파일이 정상?		// d:\\tmp\\abc.txt d:/tmp/abc.txt 
		
		int idx = filename.lastIndexOf("\\"); 
		if(idx == -1){
			idx = filename.lastIndexOf("/");
		}
		
		filename = filename.substring(idx + 1);
	//	File uploadFile = new File(dir, filename);
		File uploadFile = new File(dir, newfilename); // 새로운 파일 명으로
	
		try{	
			fileItem.write(uploadFile);		// 실제 upload되는 부분
		}catch(Exception e){
			e.printStackTrace();
		}		
	}
	return filename;	// DB에 저장하기 위한 return;
}
%>    
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<%
// tomcat 배포 - server
String fupload = application.getRealPath("/upload");

// 지정 폴더 - client
// String fupload = "d:\\tmp";

System.out.println("업로드 폴더:" + fupload);

String yourTempDir = fupload;

int yourMaxRequestSize = 100 * 1024 * 1024;	// 1 Mbyte
int yourMaxMemorySize = 100 * 1024;			// 1 Kbyte

// form field의 데이터를 저장할 변수
String id = "";
String title = "";
String content = "";

// file명 저장
String filename = "";
String newfilename = "";

boolean isMultipart = ServletFileUpload.isMultipartContent(request);
if(isMultipart == true){
	
	// FileItem 생성
	DiskFileItemFactory factory = new DiskFileItemFactory();
	
	factory.setSizeThreshold(yourMaxMemorySize);
	factory.setRepository(new File(yourTempDir));
	
	ServletFileUpload upload = new ServletFileUpload(factory);
	upload.setSizeMax(yourMaxRequestSize);
	
	List<FileItem> items = upload.parseRequest(request);
	Iterator<FileItem> it = items.iterator();
	
	while(it.hasNext()){
		
		FileItem item = it.next();
		
		if(item.isFormField()){	// id, title, content
			if(item.getFieldName().equals("id")){
				id = item.getString("utf-8");
			}
			else if(item.getFieldName().equals("title")){
				title = item.getString("utf-8");
			}
			else if(item.getFieldName().equals("content")){
				content = item.getString("utf-8");
			}			
		}
		else{	// file
			if(item.getFieldName().equals("fileload")){				
				// 확장자 명
				String fileName = item.getName();
				int lastInNum = fileName.lastIndexOf(".");
				String exName = fileName.substring(lastInNum);
				
				// 새로운 파일명
				newfilename = (new Date().getTime()) + "";
				newfilename = newfilename + exName;
				System.out.println(newfilename);
								
				filename = processUploadFile(item, newfilename, fupload);
			}
		}		
	}	
}

// DB에 저장
PdsDao dao = PdsDao.getInstance();
boolean isS = dao.writePds(new PdsDto(id, title, content, filename, newfilename));
if(isS){
	%>
	<script type="text/javascript">
	alert('파일 업로드 성공');
	location.href = "pdslist.jsp";
	</script>
	<%
}else{
	%>
	<script type="text/javascript">
	alert('파일 업로드 실패');
	location.href = "pdswrite.jsp";
	</script>
	<%
}
%>

</body>
</html>








