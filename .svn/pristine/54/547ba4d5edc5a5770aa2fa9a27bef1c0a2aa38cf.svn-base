package main.test;

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.delete;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.put;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

import org.junit.Before;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import main.startup.Application;

@WebAppConfiguration
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(classes=Application.class)
public class PerformanceTestBase {

	@Autowired
	private WebApplicationContext webApplicationContext;

	private MockMvc mockMvc;

	@Before
	public void setup() throws Exception {

		mockMvc = MockMvcBuilders.webAppContextSetup(webApplicationContext).build();  
		}

	/**
	 * 用于模拟压力测试，不要打印信息、不要返回值信息
	 * @param url
	 * @param requestJsonParam
	 */
	public void testPut(String url,String requestJsonParam) throws Throwable {

		try{
			mockMvc.perform(put(url).contentType(MediaType.APPLICATION_JSON).content(requestJsonParam)).andExpect(status().isOk());
			}
		catch(Throwable e){
			e.printStackTrace();
			throw e;
			}
		}

	/**
	 * 用于模拟压力测试，不要打印信息、不要返回值信息
	 * @param url
	 * @param requestJsonParam
	 */
	public void testPost(String url,String requestJsonParam) throws Throwable {

		try{
			mockMvc.perform(post(url).contentType(MediaType.APPLICATION_JSON).content(requestJsonParam)).andExpect(status().isOk());
			}
		catch(Throwable e){
			e.printStackTrace();
			throw e;
			}
		}

	/**
	 * 用于模拟压力测试，不要打印信息、不要返回值信息
	 * @param url
	 */
	public void testDelete(String url) throws Throwable {

		try{
			mockMvc.perform(delete(url).contentType(MediaType.APPLICATION_JSON)).andExpect(status().isOk());
			}
		catch(Throwable e){
			e.printStackTrace();
			throw e;
			}
		}

	/**
	 * 用于模拟压力测试，不要打印信息、不要返回值信息
	 * @param url
	 * @param requestJsonParam
	 */
	public void testGet(String url,String requestJsonParam) throws Throwable{

		try{
			mockMvc.perform(get(url).contentType(MediaType.APPLICATION_JSON).content(requestJsonParam)).andExpect(status().isOk());
			}
		catch(Throwable e){
			e.printStackTrace();
			throw e;
			}
		}

	}
