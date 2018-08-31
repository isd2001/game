package handlers;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

/*
 * application Event�� Listener 2�� 
 *  - ServletContextListener : init, destroy
 *  
 *  - ServletContextAttributeListener : setAttribute, removeAttribute
 * 
 * �� EventListener�� ����� �ʿ���. (�ڵ����� ��ϵ��� �ʴ´�)
 * 
 */
public class ApplicationHandler implements ServletContextListener {
	long begin;
	
	@Override
	public void contextInitialized(ServletContextEvent sce) {
		// ����̹� �ε�
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
		}catch(Exception e) {
			e.printStackTrace();
		}
		begin = System.currentTimeMillis();
		/*
		 * �Ű������� �����ִ� ServletContextEvent �� ���ؼ�
		 * application�� �����Ҽ� �ִ�.
		 */
		ServletContext ctx = sce.getServletContext();	
		// JSP���� ���Ǵ� application �̶�� �̸��� ��ü.
		ctx.setRequestCharacterEncoding("UTF-8");	// Listener ������ ����
		// servlet ������������ ���� �޼���
		System.out.println("[SERVER] contextInitialized..done");
	}
	@Override
	public void contextDestroyed(ServletContextEvent sce) {
		long end = System.currentTimeMillis();
		System.out.println("[SERVER] contextDestroyed..running time.."+(end-begin) +" ms");
	}
}
