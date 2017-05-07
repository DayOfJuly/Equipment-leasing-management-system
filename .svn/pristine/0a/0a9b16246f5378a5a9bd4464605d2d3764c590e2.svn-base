package main.startup;

import javax.servlet.MultipartConfigElement;

import org.jasig.cas.client.authentication.AuthenticationFilter;
import org.jasig.cas.client.session.SingleSignOutFilter;
import org.jasig.cas.client.session.SingleSignOutHttpSessionListener;
import org.jasig.cas.client.util.AssertionThreadLocalFilter;
import org.jasig.cas.client.util.HttpServletRequestWrapperFilter;
import org.jasig.cas.client.validation.Cas20ProxyReceivingTicketValidationFilter;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.EnableAutoConfiguration;
import org.springframework.boot.context.embedded.FilterRegistrationBean;
import org.springframework.boot.context.embedded.MultipartConfigFactory;
import org.springframework.boot.context.properties.EnableConfigurationProperties;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.ImportResource;

//import com.hjd.base.CheckAuthUserLoginFilter;
import com.hjd.base.CheckMobileUserLoginFilter;
import com.hjd.base.CheckUserLoginFilter;

@ImportResource({"classpath:IocConf/Core.xml"})
@EnableConfigurationProperties({ConfigInfo.class})
@EnableAutoConfiguration
@Configuration
public class Application {
	
	
	@Autowired
	public ConfigInfo configInfo;
	
	protected final Logger logger = LoggerFactory.getLogger(this.getClass());  
	public static void main(String[] args) {
		SpringApplication.run(Application.class, args);
	}
	
	/**
	 * 过滤器，用于修改请求的响应头设置
	 * @return
	 */
	@Bean
	public CrossFilter croFilter() {
		final CrossFilter crossFilter = new CrossFilter();

		return crossFilter;
	}
	
	/**
	 * 配置文件上传大小的配置类，目前是设置上传文件的最大值是10M
	 * @return
	 */
	@Bean  
	public MultipartConfigElement multipartConfigElement() {
		MultipartConfigFactory factory = new MultipartConfigFactory();
		factory.setMaxFileSize("10240KB");

		return factory.createMultipartConfig();
		}
	
	@Bean
	public ConfigServerContainer configServerContainer() {
		final ConfigServerContainer configServerContainer = new ConfigServerContainer();

		return configServerContainer;
	}

	/**
	 * 拦截经过oauth cas后的请求，判断userInfo信息是否为空？是否过期？
	 * 如果需要重新获取userInfo信息的话，则重新获取
	 * 否则，继续访问该请求
	 */
//	@Bean
//	public CheckUserLoginFilter checkUserLoginFilter() {
//
//		final CheckUserLoginFilter checkUserLoginFilter = new CheckUserLoginFilter();
//
//		return checkUserLoginFilter;
//		}

	/**
	 * 拦截审核系统客户需要登录后，才允许访问的请求
	 * 如果session中的userInfo信息不存在，则设置返回码为532；angularjsAuditFilter会根据错误码，判断是否需要跳转到审核系统登录页面进行登录操作
	 * 反之，则不拦截，继续访问该请求
	 */
//	@Bean
//	public CheckAuthUserLoginFilter checkAuthUserLoginFilter() {
//
//		final CheckAuthUserLoginFilter checkAuthUserLogin = new CheckAuthUserLoginFilter();
//
//		return checkAuthUserLogin;
//		}

	/**
	 * 拦截移动端客户需要登录后，才允许访问的请求
	 * 如果session中的userInfo信息不存在，则设置返回码为530；移动端的angularjsFilter会根据错误码，判断是否需要跳转到移动端登录页面进行登录操作
	 * 反之，则不拦截，继续访问该请求
	 * ！！！注意：不能与checkUserLoginFilter同时使用！！！
	 */
//	@Bean
//	public CheckMobileUserLoginFilter checkMobileUserLoginFilter() {
//
//		final CheckMobileUserLoginFilter checkMobileUserLogin = new CheckMobileUserLoginFilter();
//
//		return checkMobileUserLogin;
//		}

/**
 * *******************************************************************************************************************************************************************************************************
 * 配置OAUTH：
 * 1：导入对应的JAR文件——cas-client-core-3.2.1.jar
 * 2：填写对应的配置信息——Action.properties
 * 3：创建一个获取配置信息的BEAN——ConfigInfo.java，注意这个文件中的密码传递过去的时候是经过加密的，如果这一点忘记了，是不能正确跳转回来的
 * 4：在启动项目的时候实例化对应的配置BEAN——主要在Application.java文件中配置
 * *******************************************************************************************************************************************************************************************************
 */
	
	 
//	 //listener配置
//    @Bean
//    public SingleSignOutHttpSessionListener singleSignOutHttpSessionListener(){
//        final SingleSignOutHttpSessionListener signOutHttpSessionListener = new SingleSignOutHttpSessionListener();
//
//        return signOutHttpSessionListener;
//    }
//    
//  //该过滤器用于实现单点登出功能
//    @Bean
//    public FilterRegistrationBean singleSignOutFilter(){  
//        FilterRegistrationBean filter5 = new FilterRegistrationBean();  
//        filter5.setFilter(new SingleSignOutFilter());
//
//        return filter5;  
//    }
//
//    //过滤器负责实现HttpServletRequest请求的包裹
//    @Bean
//    public FilterRegistrationBean httpServletRequestWrapperFilter(){  
//        FilterRegistrationBean filter4 = new FilterRegistrationBean();  
//        filter4.setFilter(new HttpServletRequestWrapperFilter());
//
//        return filter4;  
//    }
//
//    //该过滤器使得开发者可以通过org.jasig.cas.client.util.AssertionHolder来获取用户的登录名。
//    @Bean
//    public FilterRegistrationBean assertionThreadLocalFilter(){  
//        FilterRegistrationBean filter3 = new FilterRegistrationBean();  
//        filter3.setFilter(new AssertionThreadLocalFilter());
//
//        return filter3;  
//    }
//
//    //该过滤器负责对Ticket的校验工作，必须启用它 
//    @Bean  
//    public FilterRegistrationBean cas20ProxyReceivingTicketValidationFilter(){  
//        FilterRegistrationBean filter1 = new FilterRegistrationBean();  
//        filter1.setFilter(new Cas20ProxyReceivingTicketValidationFilter());  
//        filter1.addInitParameter("casServerUrlPrefix", configInfo.getCasServerUrlPrefix());
//        filter1.addInitParameter("serverName", configInfo.getServerName());
//        filter1.addInitParameter("redirectAfterValidation", configInfo.getRedirectAfterValidation());
//
//        return filter1;  
//    } 
//    
//    //该过滤器负责用户的认证工作，必须启用它
//    //https://demo.micmiu.com:8443/cas/login 
//    
//    //http://passport.crecgwm.com/CAS/login
//	@Bean 
//    public FilterRegistrationBean authenticationFilter(){
// 	   
//  	  FilterRegistrationBean filter2 = new FilterRegistrationBean(); 
//        filter2.setFilter(new AuthenticationFilter());
//        filter2.setUrlPatterns(configInfo.getUrlPatterns());
//        filter2.setEnabled(true);
//        filter2.addInitParameter("casServerLoginUrl", configInfo.getCasServerLoginUrl());
//        filter2.addInitParameter("serverName", configInfo.getAuthServerName());
//        filter2.addInitParameter("clientId", configInfo.getClientId());          
//        filter2.addInitParameter("secret", configInfo.getSecret());
//
//        return filter2;
//    }

}