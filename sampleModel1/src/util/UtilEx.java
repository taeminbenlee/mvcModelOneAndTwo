package util;

import java.util.List;

import calendar.CalendarDto;

public class UtilEx {
	
	// 날짜를 클릭하면 그날의 일정을 모두 볼수 있는 callist.jsp로 이동하는 함수
	
	public static String callist(int year, int month, int day) {
		String str = "";
		
		str += String.format("&nbsp;<a href='%s?year=%d&month=%d&day=%d'>", "callist.jsp", year, month, day);
		
		//"&nbap;<a href='callist.jsp?year=" + year + "&month=" + month + "&day=" + month + "'>"
		
		str += String.format("%2d", day);
		str += "</a>";
		
		return str;
	}
	// 일정을 추가하기 위해서 pen 이미지를 클릭하면 calwrite.jsp로 이동하는 함수
	public static String showPen(int year, int month, int day) {
		String str = "";
		
		String image = "<img src='image/pen2.png' width='18px' height='18px'";
		str = String.format("<a href='%s?year=%d&month=%d&day=%d'>%s</a>", "calwrite.jsp", year, month, day, image);
		
		
		return str; 
		
	}
	// 한문자를 두문자로 변경해주는 함수		1~9 -> 01~09
	public static String two(String msg) {
		return msg.trim().length()< 2?"0"+msg.trim():msg.trim();
	}
	// 달력의 날짜별로 설저할 테이블을 작성하는 함수
	public static String makeTable(int year, int month, int day, List<CalendarDto> list) {
		String str = "";
		
		String dates = (year + "") + two(month + "") + two(day + ""); 
		str += "<table>";
		str += "<col width='100'>";
		
		for (CalendarDto dto : list) {
			if(dto.getRdate().substring(0, 8).equals(dates)) {
				str += "<tr>";
				
				str +="<td style='line-height: 10px; overflow: hidden; border-collapse:collapse;border:1px blue solid'>";
				str +="<a href='caldetail.jsp?seq=" + dto.getSeq() + "'>";				
				str +="<font style='font-size: 8px; color: red;'>";	
				str += dot3(dto.getTitle());
				str +="</font>";				
				str += "</a>";				
				str += "</tr>";
			}
		}
		
		str += "</table>";
		
		return str;
	}
	// 일저으이 제목이 길때 ...으로 처리하는 함수
	public static String dot3(String msg) {
		String str = "";
		if(msg.length()>=7) {
			str = msg.substring(0, 7);
			str += "...";
		} else {
			str = msg.trim();
		}
		return str;
	}
	// nvl함수 : 문자열이 비어있는지 확인하는 함수
	public static boolean nvl(String msg) {
		return msg == null || msg.trim().equals("")?true:false;
	}
	
	
	
	
	
	
	
}
