package handlers;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

/*
 * application Event용 Listener 2개 
 *  - ServletContextListener : init, destroy
 *  
 *  - ServletContextAttributeListener : setAttribute, removeAttribute
 * 
 * ※ EventListener는 등록이 필요함. (자동으로 등록되지 않는다)
 * 
 */
public class ApplicationHandler implements ServletContextListener {
	long begin;
	
	@Override
	public void contextInitialized(ServletContextEvent sce) {
		// 드라이버 로딩
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
		}catch(Exception e) {
			e.printStackTrace();
		}
		begin = System.currentTimeMillis();
		/*
		 * 매개변수로 잡혀있는 ServletContextEvent 를 통해서
		 * application을 접근할수 있다.
		 */
		ServletContext ctx = sce.getServletContext();	
		// JSP에서 사용되는 application 이라는 이름의 객체.
		ctx.setRequestCharacterEncoding("UTF-8");	// Listener 에서만 가능
		// servlet 하위버전에는 없는 메서드
		System.out.println("[SERVER] contextInitialized..done");
	}
	@Override
	public void contextDestroyed(ServletContextEvent sce) {
		long end = System.currentTimeMillis();
		System.out.println("[SERVER] contextDestroyed..running time.."+(end-begin) +" ms");
	}
}
