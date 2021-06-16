<%@page import="calendar.CalendarDto"%>
<%@page import="java.util.List"%>
<%@page import="util.UtilEx"%>
<%@page import="calendar.CalendarDao"%>
<%@page import="dto.MemberDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

 
<%
MemberDto mem = (MemberDto)session.getAttribute("login");
 
String year = request.getParameter("year");
String month = request.getParameter("month");
String day = request.getParameter("day");
 
String dates = year + UtilEx.two(month) + UtilEx.two(day);
 
CalendarDao dao = CalendarDao.getInstance();
List<CalendarDto> list = dao.getEventList(mem.getId(), dates);
 
%>
<h4 align="right" style="background-color: #f0f0f0">환영합니다 <%=mem.getId() %>님</h4>
<table border="1">
<col width="100"><col width="200"><col width="450"><col width="50">
 
<tr bgcolor="#09bbaa">
<td>번호</td><td>시간</td><td>제목</td><td>삭제</td>
</tr>
 
<%
for(int i = 0;i < list.size(); i++){
    CalendarDto dto = list.get(i);
    %>
    <tr>
        <td><%=i + 1 %></td>
        <td><%=dto.getRdate() %> </td>
        <td>
            <a href="caldetail.jsp?seq=<%=dto.getSeq() %>"><%=dto.getTitle() %></a>
        </td>    
        <td>
            <form action="caldel.jsp" method="post">
                <input type="hidden" name="seq" value="<%=dto.getSeq() %>">
                <input type="submit" value="일정삭제">
            </form>
        </td>
    </tr>    
    <%
}
%>
</table>
 
<%
String url = String.format("%s?year=%s&month=%s", 
                        "calendarlist.jsp", year, month);
%>
<a href="<%=url %>">일정보기</a>




</body>
</html>