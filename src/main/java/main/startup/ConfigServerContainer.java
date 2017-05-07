package main.startup;

import org.springframework.boot.context.embedded.ConfigurableEmbeddedServletContainer;
import org.springframework.boot.context.embedded.EmbeddedServletContainerCustomizer;

public class ConfigServerContainer implements EmbeddedServletContainerCustomizer{

	/** 
     * @param container 
     * @see org.springframework.boot.context.embedded.EmbeddedServletContainerCustomizer#customize(org.springframework.boot.context.embedded.ConfigurableEmbeddedServletContainer) 
     */  
    @Override  
    public void customize(ConfigurableEmbeddedServletContainer container) {
    	container.setPort(80);
    }
	
}
