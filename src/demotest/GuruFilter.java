package demotest;

import java.io.IOException;
import java.util.Date;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;

public class GuruFilter implements Filter {

	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		// TODO Auto-generated method stub
		HttpServletRequest req = (HttpServletRequest) request;

		String ipAddress = req.getRemoteAddr();
		// Visible when you add /GuruFilter on the URL
		System.out.println("IP Address " + ipAddress + ", Time is" + new Date().toString());

		// pass the request along the filter chain
		chain.doFilter(request, response);
	}

	/**
	 * @see Filter#init(FilterConfig)
	 */
	public void init(FilterConfig fConfig) throws ServletException {
		String guruparam = fConfig.getInitParameter("guru-param");

		// Print the init parameter
		System.out.println("Test Param: " + guruparam);
	}

	@Override
	public void destroy() {
		// TODO Auto-generated method stub

	}
}