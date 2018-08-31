package handlers;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;

/*
 * ServletContextListener/ 
 * 	ServletContextAttributeListener 가 ServletContext에 관련된 이벤트 리스너 였다면,
 * 
 * HttpSession 에 관련된 이벤트 리스너를 살펴보려고 하는데
 * 	- HttpSessionListener : Session이 만들어지고, 파괴될때의 이벤트 감지기
 * 	- HttpSessionAttributeListener : Session에 attribute의 변화가 일어날때의 이벤트 감지기 
 * 
 */
public class SessionHandler implements HttpSessionListener {
	@Override
	public void sessionCreated(HttpSessionEvent se) {
		// 새로운 세션이 열릴때 작동.. 세션을 갖지 않는 사용자의 최초 연결시 작동
		HttpSession session = se.getSession();
		session.setAttribute("baseFlag", false);
	}
	
	@Override
	public void sessionDestroyed(HttpSessionEvent se) {
		// 이미 기존에 만들어진 세션이 닫힐때 작동..
		// 유효시간내 갱신되지 않거나, invalidate() 시키면 작동된다.
		HttpSession session = se.getSession();
		System.out.println("[SESSION] destroyed.." + session.getId());
		
	}

}
