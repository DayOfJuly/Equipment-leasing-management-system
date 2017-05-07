package main.test;

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.delete;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.put;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

import java.math.BigDecimal;
import java.sql.Date;
import java.sql.Timestamp;

import main.startup.Application;

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

@WebAppConfiguration
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(classes = Application.class)
public class TestBase {
	@Autowired
	protected WebApplicationContext webApplicationContext;
	
	public MockMvc mockMvc;

	@Before
	public void setup() throws Exception{
		 mockMvc = MockMvcBuilders.webAppContextSetup(webApplicationContext).build();  
	}
	
	
	protected Date nowDate	=	new Date(System.currentTimeMillis());
	protected Timestamp now	=	new Timestamp(System.currentTimeMillis());
	
	BigDecimal getDecimal(float value){
		return new BigDecimal(value);
	}
	
	public void printResult(String result) {
		System.out.println("=====");
		System.out.println("===============================result print start================================");
		System.out.println("=====");
		System.out.println("=====");
		System.out.println("=====");
		System.out.println("=====");
		System.out.println("=====");
		System.out.println("=====");
		System.out.println("=====");
		System.out.println("=====");
		try {
			System.out.println(JsonFormatTool.beautify(result));
		} catch (Throwable e) {
			e.printStackTrace();
			throw e;
		}
		System.out.println("=====");
		System.out.println("=====");
		System.out.println("=====");
		System.out.println("=====");
		System.out.println("=====");
		System.out.println("=====");
		System.out.println("=====");
		System.out.println("=====");
		System.out.println("===============================result print end================================");
		System.out.println("=====");
	}
	
	
	public void putTest(String path,String jsonParam) throws Throwable{
		try {
			printResult(mockMvc.perform(put(path)
					.contentType(MediaType.APPLICATION_JSON)
					.content(jsonParam)
					)
					.andExpect(status().isOk())
					.andReturn().getResponse().getContentAsString()
					);
		} catch (Throwable e) {
			e.printStackTrace();
			throw e;
		}
	}
	public void postTest(String path,String jsonParam) throws Throwable{
		try {
			printResult(mockMvc.perform(post(path)
					.contentType(MediaType.APPLICATION_JSON)
					.content(jsonParam)
					)
					.andExpect(status().isOk())
					.andReturn().getResponse().getContentAsString()
					);
		} catch (Throwable e) {
			e.printStackTrace();
			throw e;
		}
	}
	public void deleteTest(String path) throws Throwable{
		try {
			printResult(mockMvc.perform(delete(path)
					.contentType(MediaType.APPLICATION_JSON)
					)
					.andExpect(status().isOk())
					.andReturn().getResponse().getContentAsString()
					);
		} catch (Throwable e) {
			e.printStackTrace();
			throw e;
		}
	}
	
	public void getTest(String path,String jsonParam) throws Throwable{
		try {
			printResult(mockMvc.perform(get(path)
					.contentType(MediaType.APPLICATION_JSON)
					.content(jsonParam)
					)
					.andExpect(status().isOk())
					.andReturn().getResponse().getContentAsString()
					);
		} catch (Throwable e) {
			e.printStackTrace();
			throw e;
		}
	}
	
	
	
	
/******压力测试相关方法********************************************************************************************************************************************************************************/	
	
	/**
	 * 用于模拟压力测试，不要打印信息、不要返回值信息
	 * @param path
	 * @param jsonParam
	 * @throws Throwable
	 */
	public void testPut(String path,String jsonParam) throws Throwable{
		try {
			mockMvc.perform(put(path)
					.contentType(MediaType.APPLICATION_JSON)
					.content(jsonParam)
					);
		} catch (Throwable e) {
			e.printStackTrace();
			throw e;
		}
	}
	/**
	 * 用于模拟压力测试，不要打印信息、不要返回值信息
	 * @param path
	 * @param jsonParam
	 * @throws Throwable
	 */
	public void testPost(String path,String jsonParam) throws Throwable{
		try {
			mockMvc.perform(post(path)
					.contentType(MediaType.APPLICATION_JSON)
					.content(jsonParam)
					)
					.andExpect(status().isOk())
					.andReturn().getResponse().getContentAsString();
		} catch (Throwable e) {
			e.printStackTrace();
			throw e;
		}
	}
	/**
	 * 用于模拟压力测试，不要打印信息、不要返回值信息
	 * @param path
	 * @throws Throwable
	 */
	public void testDelete(String path) throws Throwable{
		try {
			mockMvc.perform(delete(path)
					.contentType(MediaType.APPLICATION_JSON)
					);
		} catch (Throwable e) {
			e.printStackTrace();
			throw e;
		}
	}
	/**
	 * 用于模拟压力测试，不要打印信息、不要返回值信息
	 * @param path
	 * @param jsonParam
	 * @throws Throwable
	 */
	public void testGet(String path,String jsonParam) throws Throwable{
		try {
			mockMvc.perform(get(path)
					.contentType(MediaType.APPLICATION_JSON)
					.content(jsonParam)
					);
		} catch (Throwable e) {
			e.printStackTrace();
			throw e;
		}
	}
	
}
