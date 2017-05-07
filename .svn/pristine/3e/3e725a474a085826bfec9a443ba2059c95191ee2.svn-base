package main.test;

import java.util.Date;
import java.util.Map;

import org.junit.Test;
import org.junit.runner.JUnitCore;
import org.junit.runner.Request;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.hjd.action.bean.OutputDataSearchBean;
import com.hjd.util.BeanUtil;

	public class PerformanceTest extends PerformanceTestBase 
	{
			//交易执行的次数
			private static final int   RUN_COUNT=100;
			//线程并发的次数
			private static final int   THREAD_COUNT=1;
			
		/*	//交易执行的次数
			private static final int   RUN_COUNT=1;
			//线程并发的次数
			private static final int   THREAD_COUNT=1;*/

		   /**
		    * 主函数，模拟多线程测试
		    * @param args
		    */
			public static void main(String[] args) 
			{
				Runnable r=new TestRunnable();
				Thread t = null;
				for(int i=0;i<THREAD_COUNT;i++)
				{
					t =  new Thread(r);
					t.start();
				}
			}
			
			/**
			 * 为了减少代码的编写量，简单封装一个打印交易执行信息的方法
			 * @param url
			 * @param startTime
			 */
		    private void printRunInfo(String url,Long startTime)
		    {
			     Long endTime=new Date().getTime();
		//	     logger.info("开始时间："+startTime+"   结束时间："+endTime+"   总时间："+(endTime-startTime)+"   平均时间："+(endTime-startTime)/1000+"---"+this.toString());
			     System.err.println("\n交易（"+url+"）执行了"+RUN_COUNT+"次，总执行时间是："+(endTime-startTime)+"   平均执行时间是："+(endTime-startTime)/RUN_COUNT+"   执行线程是："+this.toString());
		    }
		    
			/**
			 * 测试方法，获取供应商的信息
			 * @throws Throwable
			 */
			@Test
			public void junitTest() throws Throwable
			{
				 Long startTime=new Date().getTime();
				 
				 ObjectMapper mapper = new ObjectMapper();
				 String url="/Issue?Action=GetProviders";
				 OutputDataSearchBean testTableSearchBean = new OutputDataSearchBean();
				 String jsonStr = mapper.writeValueAsString(testTableSearchBean);
			     for(int i=0;i<RUN_COUNT;i++)
			     {
				      testPost(url,jsonStr);
			     }
			     printRunInfo(url,startTime);
			}
			
			/**
			 * 测试方法，获取资源统计的信息
			 * @throws Throwable
			 */
			@Test
			public void junitTest1() throws Throwable
			{
				 Long startTime=new Date().getTime();
				 
				 ObjectMapper mapper = new ObjectMapper();
				 String url="/Issue?Action=ResourceCount";
				 OutputDataSearchBean testTableSearchBean = new OutputDataSearchBean();
				 String jsonStr = mapper.writeValueAsString(testTableSearchBean);
			     for(int i=0;i<RUN_COUNT;i++)
			     {
				      testGet(url,jsonStr);
			     }
			     printRunInfo(url,startTime);
			}
			
			/**
			 * 测试方法，获取资源统计的信息
			 * @throws Throwable
			 */
			@Test
			public void junitTest2() throws Throwable
			{
				 Long startTime=new Date().getTime();
				 
				 ObjectMapper mapper = new ObjectMapper();
				 String url="/BG/Party/Ent";
				 OutputDataSearchBean testTableSearchBean = new OutputDataSearchBean();
				 String jsonStr = mapper.writeValueAsString(testTableSearchBean);
				 
				 String jsonStrTemp="{\"code\":\"000xxx\",\"parentCode\":\"000\",\"name\":\"中铁\",\"orgLevel\":\"2\",\"note\":\"test\",\"parentOrgId\":\"1\"}";
				 Map objMap=BeanUtil.toObjectFromJson(jsonStrTemp, Map.class);
			     for(int i=0;i<RUN_COUNT;i++)
			     {
			    	 objMap.put("name", "企业"+new Date().getTime());
			    	 jsonStr=BeanUtil.toJsonString(objMap);
				      testPut(url,jsonStr);
			     }
			     printRunInfo(url,startTime);
			}
			
			/**
			 * 测试方法，项目设置下拉框企业查询
			 * @throws Throwable
			 */
			@Test
			public void junitTestQueryYin3() throws Throwable
			{
				 Long startTime=new Date().getTime();
				 
				 ObjectMapper mapper = new ObjectMapper();
				 String url="/BG/Party/Ent";
				 String jsonStrTemp="{\"currOrgId\": \"1\", \"pageNo\": 0, \"pageSize\": 99}";
				 OutputDataSearchBean testTableSearchBean = new OutputDataSearchBean();
				 String jsonStr = mapper.writeValueAsString(testTableSearchBean);
				 jsonStr = jsonStrTemp;
			     for(int i=0;i<RUN_COUNT;i++)
			     {
				      testPost(url,jsonStr);
			     }
			     printRunInfo(url,startTime);
			}
			
			/**
			 * 测试方法，项目设置展示数据查询
			 * @throws Throwable
			 */
			@Test
			public void junitTestQueryYin4() throws Throwable
			{
				 Long startTime=new Date().getTime();
				 
				 ObjectMapper mapper = new ObjectMapper();
				 String url="/BG/Party/Pro";
				 String jsonStrTemp="{\"currOrgId\": \"1\", \"pageNo\": 0, \"pageSize\": 10}";
				 OutputDataSearchBean testTableSearchBean = new OutputDataSearchBean();
				 String jsonStr = mapper.writeValueAsString(testTableSearchBean);
				 jsonStr = jsonStrTemp;
			     for(int i=0;i<RUN_COUNT;i++)
			     {
				      testPost(url,jsonStr);
			     }
			     printRunInfo(url,startTime);
			}
			
			/**
			 * 测试方法，员工信息数据查询
			 * @throws Throwable
			 */
			@Test
			public void junitTestQueryYin5() throws Throwable
			{
				 Long startTime=new Date().getTime();
				 
				 ObjectMapper mapper = new ObjectMapper();
				 String url="/BG/Party/Per";
				 String jsonStrTemp="{\"parTypeId\": 3, \"orgCode\": \"000\", \"departmentName\": \"总公司\", \"currOrgId\": \"1\", \"pageNo\": 0, \"pageSize\": 10}";
				 OutputDataSearchBean testTableSearchBean = new OutputDataSearchBean();
				 String jsonStr = mapper.writeValueAsString(testTableSearchBean);
				 jsonStr = jsonStrTemp;
			     for(int i=0;i<RUN_COUNT;i++)
			     {
				      testPost(url,jsonStr);
			     }
			     printRunInfo(url,startTime);
			}
			
			/**
			 * 测试方法，外部员工信息数据查询
			 * @throws Throwable
			 */
			@Test
			public void junitTestQueryYin6() throws Throwable
			{
				 Long startTime=new Date().getTime();
				 
				 ObjectMapper mapper = new ObjectMapper();
				 String url="/BG/Party/Provider";
				 String jsonStrTemp="{\"parTypeId\": 3, \"orgCode\": \"000\", \"departmentName\": \"总公司\", \"currOrgId\": \"1\", \"pageNo\": 0, \"pageSize\": 10}";
				 OutputDataSearchBean testTableSearchBean = new OutputDataSearchBean();
				 String jsonStr = mapper.writeValueAsString(testTableSearchBean);
				 jsonStr = jsonStrTemp;
			     for(int i=0;i<RUN_COUNT;i++)
			     {
				      testPost(url,jsonStr);
			     }
			     printRunInfo(url,startTime);
			}
			
			
			
			/**
			 * 测试方法，资源管理展示信息查询（内部）
			 * @throws Throwable
			 */
			@Test
			public void junitTestQueryYin8() throws Throwable
			{
				 Long startTime=new Date().getTime();
				 
				 ObjectMapper mapper = new ObjectMapper();
				 String url="/BG/Equipment?Action=AllUseOwn";
				 String jsonStrTemp="{\"pageNo\": 0, \"pageSize\": 20, \"orgCode\": \"000\", \"orgName\": \"总公司\"}";
				 OutputDataSearchBean testTableSearchBean = new OutputDataSearchBean();
				 String jsonStr = mapper.writeValueAsString(testTableSearchBean);
				 jsonStr = jsonStrTemp;
			     for(int i=0;i<RUN_COUNT;i++)
			     {
				      testPost(url,jsonStr);
			     }
			     printRunInfo(url,startTime);
			}
			
			/**
			 * 测试方法，分类设备维护查询（左边大类）
			 * @throws Throwable
			 */
			@Test
			public void junitTestQueryYin9() throws Throwable
			{
				 Long startTime=new Date().getTime();
				 
				 ObjectMapper mapper = new ObjectMapper();
				 String url="/BG/Category?Action=EquCategory&pageNo=0&pageSize=10";
				 OutputDataSearchBean testTableSearchBean = new OutputDataSearchBean();
				 String jsonStr = mapper.writeValueAsString(testTableSearchBean);
			     for(int i=0;i<RUN_COUNT;i++)
			     {
				      testGet(url,jsonStr);
			     }
			     printRunInfo(url,startTime);
			}
			
			/**
			 * 测试方法，分类设备维护查询（右边小类）
			 * @throws Throwable
			 */
			@Test
			public void junitTestQueryYin10() throws Throwable
			{
				 Long startTime=new Date().getTime();
				 
				 ObjectMapper mapper = new ObjectMapper();
				 String url="/BG/Category?Action=EquName&equCategoryId=44&pageNo=0&pageSize=20";
				 OutputDataSearchBean testTableSearchBean = new OutputDataSearchBean();
				 String jsonStr = mapper.writeValueAsString(testTableSearchBean);
			     for(int i=0;i<RUN_COUNT;i++)
			     {
				      testGet(url,jsonStr);
			     }
			     printRunInfo(url,startTime);
			}
			
			/**
			 * 测试方法，机械设备分类管理
			 * @throws Throwable
			 */
			@Test
			public void junitTestQueryYin12() throws Throwable
			{
				 Long startTime=new Date().getTime();
				 
				 ObjectMapper mapper = new ObjectMapper();
				 String url="/BG/Category?Action=All&pageNo=0&pageSize=20";
				 OutputDataSearchBean testTableSearchBean = new OutputDataSearchBean();
				 String jsonStr = mapper.writeValueAsString(testTableSearchBean);
			     for(int i=0;i<RUN_COUNT;i++)
			     {
				      testGet(url,jsonStr);
			     }
			     printRunInfo(url,startTime);
			}
			
			/**
			 * 测试方法，折旧费查询
			 * @throws Throwable
			 */
			@Test
			public void junitTestQueryYin13() throws Throwable
			{
				 Long startTime=new Date().getTime();
				 
				 ObjectMapper mapper = new ObjectMapper();
				 String url="/BG/DepreciationHist";
				 String jsonStrTemp="{\"pageNo\": 0, \"pageSize\": 20, \"isInclude\": 0, \"orgName\": \"中铁一局\", \"month\": \"2016-03\", \"orgCode\": \"000000\"}";
				 OutputDataSearchBean testTableSearchBean = new OutputDataSearchBean();
				 String jsonStr = mapper.writeValueAsString(testTableSearchBean);
				 jsonStr = jsonStrTemp;
			     for(int i=0;i<RUN_COUNT;i++)
			     {
				      testPost(url,jsonStr);
			     }
			     printRunInfo(url,startTime);
			}
			
			/**
			 * 测试方法，租赁费登记-设备拥有者
			 * @throws Throwable
			 */
			@Test
			public void junitTestQueryYin14() throws Throwable
			{
				 Long startTime=new Date().getTime();
				 
				 ObjectMapper mapper = new ObjectMapper();
				 String url="/BG/RentHistOwner";
				 String jsonStrTemp="{\"pageNo\": 0, \"pageSize\": 10, \"isInclude\": 0, \"orgCode\": \"000000\", \"month\": \"2016-03\"}";
				 OutputDataSearchBean testTableSearchBean = new OutputDataSearchBean();
				 String jsonStr = mapper.writeValueAsString(testTableSearchBean);
				 jsonStr = jsonStrTemp;
			     for(int i=0;i<RUN_COUNT;i++)
			     {
				      testPost(url,jsonStr);
			     }
			     printRunInfo(url,startTime);
			}
			
			
			/**
			 * 测试方法，租赁费登记-设备使用者
			 * @throws Throwable
			 */
			@Test
			public void junitTestQueryYin15() throws Throwable
			{
				 Long startTime=new Date().getTime();
				 
				 ObjectMapper mapper = new ObjectMapper();
				 String url="/BG/RentHistUser";
				 String jsonStrTemp="{\"orgCode\": \"000000\", \"pageNo\": 0, \"pageSize\": 20, \"isInclude\": 0, \"month\": \"2016-03\"}";
				 OutputDataSearchBean testTableSearchBean = new OutputDataSearchBean();
				 String jsonStr = mapper.writeValueAsString(testTableSearchBean);
				 jsonStr = jsonStrTemp;
			     for(int i=0;i<RUN_COUNT;i++)
			     {
				      testPost(url,jsonStr);
			     }
			     printRunInfo(url,startTime);
			}
			
			
			/**
			 * 测试方法，发布结果登记
			 * @throws Throwable
			 */
			@Test
			public void junitTestQueryYin16() throws Throwable
			{
				 Long startTime=new Date().getTime();
				 
				 ObjectMapper mapper = new ObjectMapper();
				 String url="/BG/BusPublishHist";
				 String jsonStrTemp="{\"pageNo\": 0, \"pageSize\": 20, \"startReleaseDate\": \"2016-02-29\", \"endReleaseDate\": \"2016-03-29\"}";
				 OutputDataSearchBean testTableSearchBean = new OutputDataSearchBean();
				 String jsonStr = mapper.writeValueAsString(testTableSearchBean);
				 jsonStr = jsonStrTemp;
			     for(int i=0;i<RUN_COUNT;i++)
			     {
				      testPost(url,jsonStr);
			     }
			     printRunInfo(url,startTime);
			}
			
	
			/**
			 * 测试方法，资源管理查询（外部）
			 * @throws Throwable
			 */
			@Test
			public void junitTestQueryYin17() throws Throwable
			{
				 Long startTime=new Date().getTime();
				 
				 ObjectMapper mapper = new ObjectMapper();
				 String url="/BG/DepreciationHist?Action=Provider";
				 String jsonStrTemp="{\"pageNo\": 0, \"pageSize\": 20, \"month\": \"2016-03\"}";
				 OutputDataSearchBean testTableSearchBean = new OutputDataSearchBean();
				 String jsonStr = mapper.writeValueAsString(testTableSearchBean);
				 jsonStr = jsonStrTemp;
			     for(int i=0;i<RUN_COUNT;i++)
			     {
				      testPost(url,jsonStr);
			     }
			     printRunInfo(url,startTime);
			}
			
			/**
			 * 测试方法，资源管理查询（外部）
			 * @throws Throwable
			 */
			@Test
			public void junitTestQueryYin18() throws Throwable
			{
				 Long startTime=new Date().getTime();
				 
				 ObjectMapper mapper = new ObjectMapper();
				 String url="/BG/DepreciationHist?Action=Provider";
				 String jsonStrTemp="{\"pageNo\": 0, \"pageSize\": 20, \"month\": \"2016-03\"}";
				 OutputDataSearchBean testTableSearchBean = new OutputDataSearchBean();
				 String jsonStr = mapper.writeValueAsString(testTableSearchBean);
				 jsonStr = jsonStrTemp;
			     for(int i=0;i<RUN_COUNT;i++)
			     {
				      testPost(url,jsonStr);
			     }
			     printRunInfo(url,startTime);
			}
			
			
			/**
			 * 测试方法，联系方式维护查询
			 * @throws Throwable
			 */
			@Test
			public void junitTestQueryYin20() throws Throwable
			{
				 Long startTime=new Date().getTime();
				 
				 ObjectMapper mapper = new ObjectMapper();
				 String url="/BG/Party/ContactInfo";
				 String jsonStrTemp="{\"currOrgId\": \"329\", \"pageNo\": 0, \"pageSize\": 10}";
				 OutputDataSearchBean testTableSearchBean = new OutputDataSearchBean();
				 String jsonStr = mapper.writeValueAsString(testTableSearchBean);
				 jsonStr = jsonStrTemp;
			     for(int i=0;i<RUN_COUNT;i++)
			     {
				      testPost(url,jsonStr);
			     }
			     printRunInfo(url,startTime);
			}
			
			
			/**
			 * 测试方法，折旧费登记查询（外部）
			 * @throws Throwable
			 */
			@Test
			public void junitTestQueryYin21() throws Throwable
			{
				 Long startTime=new Date().getTime();
				 
				 ObjectMapper mapper = new ObjectMapper();
				 String url="/BG/DepreciationHist?Action=Provider";
				 String jsonStrTemp="{\"pageNo\": 0, \"pageSize\": 20, \"month\": \"2016-03\"}";
				 OutputDataSearchBean testTableSearchBean = new OutputDataSearchBean();
				 String jsonStr = mapper.writeValueAsString(testTableSearchBean);
				 jsonStr = jsonStrTemp;
			     for(int i=0;i<RUN_COUNT;i++)
			     {
				      testPost(url,jsonStr);
			     }
			     printRunInfo(url,startTime);
			}
			
			/**
			 * 测试方法，租赁费登记-设备拥有者查询（外部）
			 * @throws Throwable
			 */
			@Test
			public void junitTestQueryYin22() throws Throwable
			{
				 Long startTime=new Date().getTime();
				 
				 ObjectMapper mapper = new ObjectMapper();
				 String url="/BG/RentHistOwner";
				 String jsonStrTemp="{\"pageNo\": 0, \"pageSize\": 20, \"isProvider\": 1}";
				 OutputDataSearchBean testTableSearchBean = new OutputDataSearchBean();
				 String jsonStr = mapper.writeValueAsString(testTableSearchBean);
				 jsonStr = jsonStrTemp;
			     for(int i=0;i<RUN_COUNT;i++)
			     {
				      testPost(url,jsonStr);
			     }
			     printRunInfo(url,startTime);
			}
			
			/**
			 * 测试方法，租赁费登记-设备使用者查询（外部）
			 * @throws Throwable
			 */
			@Test
			public void junitTestQueryYin23() throws Throwable
			{
				 Long startTime=new Date().getTime();
				 
				 ObjectMapper mapper = new ObjectMapper();
				 String url="/BG/RentHistUser";
				 String jsonStrTemp="{\"orgCode\": \"provider\", \"pageNo\": 0, \"pageSize\": 20, \"isProvider\": 1, \"month\": \"2016-03\"}";
				 OutputDataSearchBean testTableSearchBean = new OutputDataSearchBean();
				 String jsonStr = mapper.writeValueAsString(testTableSearchBean);
				 jsonStr = jsonStrTemp;
			     for(int i=0;i<RUN_COUNT;i++)
			     {
				      testPost(url,jsonStr);
			     }
			     printRunInfo(url,startTime);
			}
			
			/**
			 * 测试方法，租赁费登记-设备使用者查询（外部）
			 * @throws Throwable
			 */
			@Test
			public void junitTestQueryYin24() throws Throwable
			{
				 Long startTime=new Date().getTime();
				 
				 ObjectMapper mapper = new ObjectMapper();
				 String url="/BG/BusPublishHist";
				 String jsonStrTemp="{\"pageNo\": 0, \"pageSize\": 20, \"startReleaseDate\": \"2016-02-29\", \"endReleaseDate\": \"2016-03-29\"}";
				 OutputDataSearchBean testTableSearchBean = new OutputDataSearchBean();
				 String jsonStr = mapper.writeValueAsString(testTableSearchBean);
				 jsonStr = jsonStrTemp;
			     for(int i=0;i<RUN_COUNT;i++)
			     {
				      testPost(url,jsonStr);
			     }
			     printRunInfo(url,startTime);
			}
			
			/**
			 * 测试方法，企业设置查看
			 * @throws Throwable
			 */
			@Test
			public void junitTestQueryYin26() throws Throwable
			{
				 Long startTime=new Date().getTime();
				 
				 ObjectMapper mapper = new ObjectMapper();
				 String url="/BG/Party/Ent/322";
				 OutputDataSearchBean testTableSearchBean = new OutputDataSearchBean();
				 String jsonStr = mapper.writeValueAsString(testTableSearchBean);
			     for(int i=0;i<RUN_COUNT;i++)
			     {
				      testGet(url,jsonStr);
			     }
			     printRunInfo(url,startTime);
			}
			
			/**
			 * 测试方法，项目设置查看
			 * @throws Throwable
			 */
			@Test
			public void junitTestQueryYin27() throws Throwable
			{
				 Long startTime=new Date().getTime();
				 
				 ObjectMapper mapper = new ObjectMapper();
				 String url="/BG/Party/Pro/320";
				 OutputDataSearchBean testTableSearchBean = new OutputDataSearchBean();
				 String jsonStr = mapper.writeValueAsString(testTableSearchBean);
			     for(int i=0;i<RUN_COUNT;i++)
			     {
				      testGet(url,jsonStr);
			     }
			     printRunInfo(url,startTime);
			}
			
			/**
			 * 测试方法，员工信息查看
			 * @throws Throwable
			 */
			@Test
			public void junitTestQueryYin28() throws Throwable
			{
				 Long startTime=new Date().getTime();
				 
				 ObjectMapper mapper = new ObjectMapper();
				 String url="/BG/Party/Per/321";
				 OutputDataSearchBean testTableSearchBean = new OutputDataSearchBean();
				 String jsonStr = mapper.writeValueAsString(testTableSearchBean);
			     for(int i=0;i<RUN_COUNT;i++)
			     {
				      testGet(url,jsonStr);
			     }
			     printRunInfo(url,startTime);
			}
			
			/**
			 * 测试方法，外部员工信息查看
			 * @throws Throwable
			 */
			@Test
			public void junitTestQueryYin29() throws Throwable
			{
				 Long startTime=new Date().getTime();
				 
				 ObjectMapper mapper = new ObjectMapper();
				 String url="/BG/Party/Provider/2797";
				 OutputDataSearchBean testTableSearchBean = new OutputDataSearchBean();
				 String jsonStr = mapper.writeValueAsString(testTableSearchBean);
			     for(int i=0;i<RUN_COUNT;i++)
			     {
				      testGet(url,jsonStr);
			     }
			     printRunInfo(url,startTime);
			}
			
			
			/**
			 * 测试方法，资源管理查看
			 * @throws Throwable
			 */
			@Test
			public void junitTestQueryYin30() throws Throwable
			{
				 Long startTime=new Date().getTime();
				 
				 ObjectMapper mapper = new ObjectMapper();
				 String url="/BG/Equipment/3";
				 OutputDataSearchBean testTableSearchBean = new OutputDataSearchBean();
				 String jsonStr = mapper.writeValueAsString(testTableSearchBean);
			     for(int i=0;i<RUN_COUNT;i++)
			     {
				      testGet(url,jsonStr);
			     }
			     printRunInfo(url,startTime);
			}
			
			
			/**
			 * 测试方法，租赁费登记-设备拥有者查看
			 * @throws Throwable
			 */
			@Test
			public void junitTestQueryYin32() throws Throwable
			{
				 Long startTime=new Date().getTime();
				 
				 ObjectMapper mapper = new ObjectMapper();
				 String url="/BG/RentHistOwner?equipmentId=229&month=2016-02&pageNo=0&pageSize=10";
				 OutputDataSearchBean testTableSearchBean = new OutputDataSearchBean();
				 String jsonStr = mapper.writeValueAsString(testTableSearchBean);
			     for(int i=0;i<RUN_COUNT;i++)
			     {
				      testGet(url,jsonStr);
			     }
			     printRunInfo(url,startTime);
			}
			
			
			/**
			 * 测试方法，发布结果登记查看
			 * @throws Throwable
			 */
			@Test
			public void junitTestQueryYin35() throws Throwable
			{
				 Long startTime=new Date().getTime();
				 
				 ObjectMapper mapper = new ObjectMapper();
				 String url="/BG/BusPublishHist/940";
				 OutputDataSearchBean testTableSearchBean = new OutputDataSearchBean();
				 String jsonStr = mapper.writeValueAsString(testTableSearchBean);
			     for(int i=0;i<RUN_COUNT;i++)
			     {
				      testGet(url,jsonStr);
			     }
			     printRunInfo(url,startTime);
			}
		
			/**
			 * 测试方法，资源管理查看（外部）
			 * @throws Throwable
			 */
			@Test
			public void junitTestQueryYin36() throws Throwable
			{
				 Long startTime=new Date().getTime();
				 
				 ObjectMapper mapper = new ObjectMapper();
				 String url="/BG/Equipment/4";
				 OutputDataSearchBean testTableSearchBean = new OutputDataSearchBean();
				 String jsonStr = mapper.writeValueAsString(testTableSearchBean);
			     for(int i=0;i<RUN_COUNT;i++)
			     {
				      testGet(url,jsonStr);
			     }
			     printRunInfo(url,startTime);
			}
			
			
			/**
			 * 测试方法，设备拥有者查看（外部）
			 * @throws Throwable
			 */
			@Test
			public void junitTestQueryYin37() throws Throwable
			{
				 Long startTime=new Date().getTime();
				 
				 ObjectMapper mapper = new ObjectMapper();
				 String url="/BG/RentHistOwner?equipmentId=423&month=2016-03&pageNo=0&pageSize=20";
				 OutputDataSearchBean testTableSearchBean = new OutputDataSearchBean();
				 String jsonStr = mapper.writeValueAsString(testTableSearchBean);
			     for(int i=0;i<RUN_COUNT;i++)
			     {
				      testGet(url,jsonStr);
			     }
			     printRunInfo(url,startTime);
			}
			
			
			/**
			 * 测试方法，发布结果登记查看（外部）
			 * @throws Throwable
			 */
			@Test
			public void junitTestQueryYin38() throws Throwable
			{
				 Long startTime=new Date().getTime();
				 
				 ObjectMapper mapper = new ObjectMapper();
				 String url="/BG/BusPublishHist/954";
				 OutputDataSearchBean testTableSearchBean = new OutputDataSearchBean();
				 String jsonStr = mapper.writeValueAsString(testTableSearchBean);
			     for(int i=0;i<RUN_COUNT;i++)
			     {
				      testGet(url,jsonStr);
			     }
			     printRunInfo(url,startTime);
			}
		
			
			/**
			 * 测试方法，分类设备维护查看（左边大类）
			 * @throws Throwable
			 */
			@Test
			public void junitTestQueryYin39() throws Throwable
			{
				 Long startTime=new Date().getTime();
				 
				 ObjectMapper mapper = new ObjectMapper();
				 String url="/BG/Category/36?Action=EquCategoryId";
				 OutputDataSearchBean testTableSearchBean = new OutputDataSearchBean();
				 String jsonStr = mapper.writeValueAsString(testTableSearchBean);
			     for(int i=0;i<RUN_COUNT;i++)
			     {
				      testGet(url,jsonStr);
			     }
			     printRunInfo(url,startTime);
			}
			
			/**
			 * 测试方法，分类设备维护查看（右边小类）
			 * @throws Throwable
			 */
			@Test
			public void junitTestQueryYin40() throws Throwable
			{
				 Long startTime=new Date().getTime();
				 
				 ObjectMapper mapper = new ObjectMapper();
				 String url="/BG/Category/185?Action=EquNameId";
				 OutputDataSearchBean testTableSearchBean = new OutputDataSearchBean();
				 String jsonStr = mapper.writeValueAsString(testTableSearchBean);
			     for(int i=0;i<RUN_COUNT;i++)
			     {
				      testGet(url,jsonStr);
			     }
			     printRunInfo(url,startTime);
			}
			
			
			/**
			 * 测试方法，分类设备维护查看（右边小类）
			 * @throws Throwable
			 */
			@Test
			public void junitTestQueryYin41() throws Throwable
			{
				 Long startTime=new Date().getTime();
				 
				 ObjectMapper mapper = new ObjectMapper();
				 String url="/BG/Party/ContactInfo/31";
				 OutputDataSearchBean testTableSearchBean = new OutputDataSearchBean();
				 String jsonStr = mapper.writeValueAsString(testTableSearchBean);
			     for(int i=0;i<RUN_COUNT;i++)
			     {
				      testGet(url,jsonStr);
			     }
			     printRunInfo(url,startTime);
			}
			
			
			/**
			 * 测试方法，查询当前单位及其下属单位
			 * @throws Throwable
			 */
			@Test
			public void junitTestQueryYin42() throws Throwable
			{
				 Long startTime=new Date().getTime();
				 
				 ObjectMapper mapper = new ObjectMapper();
				 String url="/BG/Party/Ent?Action=QueryEnts";
				 String jsonStrTemp = "{\"orgCode\": \"000000\", \"orgName\": \"中铁一局\", \"pageNo\": 0, \"pageSize\": 10}";
				 OutputDataSearchBean testTableSearchBean = new OutputDataSearchBean();
				 String jsonStr = mapper.writeValueAsString(testTableSearchBean);
				 jsonStr = jsonStrTemp;
			     for(int i=0;i<RUN_COUNT;i++)
			     {
				      testPost(url,jsonStr);
			     }
			     printRunInfo(url,startTime);
			}
		
			
			/**
			 * 测试方法，查询当前单位下的员工
			 * @throws Throwable
			 */
			@Test
			public void junitTestQueryYin43() throws Throwable
			{
				 Long startTime=new Date().getTime();
				 
				 ObjectMapper mapper = new ObjectMapper();
				 String url="/BG/Party/Pro";
				 String jsonStrTemp = "{\"currOrgId\": 318, \"pageNo\": 0, \"pageSize\": 999999999, \"state\": 0}";
				 OutputDataSearchBean testTableSearchBean = new OutputDataSearchBean();
				 String jsonStr = mapper.writeValueAsString(testTableSearchBean);
				 jsonStr = jsonStrTemp;
			     for(int i=0;i<RUN_COUNT;i++)
			     {
				      testPost(url,jsonStr);
			     }
			     printRunInfo(url,startTime);
			}
			
			
			/**
			 * 测试方法，员工信息维护添加模态框中登录用户名查询
			 * @throws Throwable
			 */
			@Test
			public void junitTestQueryYin44() throws Throwable
			{
				 Long startTime=new Date().getTime();
				 
				 ObjectMapper mapper = new ObjectMapper();
				 String url="/BG/Party/CheckSysUser/ghyzj2";
				 //String jsonStrTemp = "{\"currOrgId\": 318, \"pageNo\": 0, \"pageSize\": 999999999, \"state\": 0}";
				 OutputDataSearchBean testTableSearchBean = new OutputDataSearchBean();
				 String jsonStr = mapper.writeValueAsString(testTableSearchBean);
				 //jsonStr = jsonStrTemp;
			     for(int i=0;i<RUN_COUNT;i++)
			     {
				      testGet(url,jsonStr);
			     }
			     printRunInfo(url,startTime);
			}
			
			/**
			 * 测试方法，员工信息维护添加模态框中员工编号查询
			 * @throws Throwable
			 */
			@Test
			public void junitTestQueryYin45() throws Throwable
			{
				 Long startTime=new Date().getTime();
				 
				 ObjectMapper mapper = new ObjectMapper();
				 String url="/BG/Party/Per?code=123123123";
				 //String jsonStrTemp = "{\"currOrgId\": 318, \"pageNo\": 0, \"pageSize\": 999999999, \"state\": 0}";
				 OutputDataSearchBean testTableSearchBean = new OutputDataSearchBean();
				 String jsonStr = mapper.writeValueAsString(testTableSearchBean);
				 //jsonStr = jsonStrTemp;
			     for(int i=0;i<RUN_COUNT;i++)
			     {
				      testGet(url,jsonStr);
			     }
			     printRunInfo(url,startTime);
			}
			
			/**
			 * 测试方法，员工信息维护添加模态框中授权功能查询
			 * @throws Throwable
			 */
			@Test
			public void junitTestQueryYin46() throws Throwable
			{
				 Long startTime=new Date().getTime();
				 
				 ObjectMapper mapper = new ObjectMapper();
				 String url="/Sys/Func";
				 String jsonStrTemp = "{\"funType\": 1}";
				 OutputDataSearchBean testTableSearchBean = new OutputDataSearchBean();
				 String jsonStr = mapper.writeValueAsString(testTableSearchBean);
				 jsonStr = jsonStrTemp;
			     for(int i=0;i<RUN_COUNT;i++)
			     {
				      testPost(url,jsonStr);
			     }
			     printRunInfo(url,startTime);
			}
			
			
			/**
			 * 测试方法，员工信息维护添加模态框中查询是否存在管理员
			 * @throws Throwable
			 */
			@Test
			public void junitTestQueryYin47() throws Throwable
			{
				 Long startTime=new Date().getTime();
				 
				 ObjectMapper mapper = new ObjectMapper();
				 String url="/BG/Party/Per?Action=GetAdmin&parentOrgId=318";
				 //String jsonStrTemp = "{\"funType\": 1}";
				 OutputDataSearchBean testTableSearchBean = new OutputDataSearchBean();
				 String jsonStr = mapper.writeValueAsString(testTableSearchBean);
				 //jsonStr = jsonStrTemp;
			     for(int i=0;i<RUN_COUNT;i++)
			     {
				      testGet(url,jsonStr);
			     }
			     printRunInfo(url,startTime);
			}
			
			/**
			 * 测试方法，外部员工信息维护管理权限查询
			 * @throws Throwable
			 */
			@Test
			public void junitTestQueryYin48() throws Throwable
			{
				 Long startTime=new Date().getTime();
				 
				 ObjectMapper mapper = new ObjectMapper();
				 String url="/Sys/Func";
				 String jsonStrTemp = "{\"funType\": 2}";
				 OutputDataSearchBean testTableSearchBean = new OutputDataSearchBean();
				 String jsonStr = mapper.writeValueAsString(testTableSearchBean);
				 jsonStr = jsonStrTemp;
			     for(int i=0;i<RUN_COUNT;i++)
			     {
				      testPost(url,jsonStr);
			     }
			     printRunInfo(url,startTime);
			}
			
			/**
			 * 测试方法，外部员工信息维护登陆人查询
			 * @throws Throwable
			 */
			@Test
			public void junitTestQueryYin49() throws Throwable
			{
				 Long startTime=new Date().getTime();
				 
				 ObjectMapper mapper = new ObjectMapper();
				 String url="/Sys/Func";
				 String jsonStrTemp = "{\"funType\": 2}";
				 OutputDataSearchBean testTableSearchBean = new OutputDataSearchBean();
				 String jsonStr = mapper.writeValueAsString(testTableSearchBean);
				 jsonStr = jsonStrTemp;
			     for(int i=0;i<RUN_COUNT;i++)
			     {
				      testPost(url,jsonStr);
			     }
			     printRunInfo(url,startTime);
			}
			
			/**
			 * 测试方法，外部员工信息维护登陆人查询
			 * @throws Throwable
			 */
			@Test
			public void junitTestQueryYin50() throws Throwable
			{
				 Long startTime=new Date().getTime();
				 
				 ObjectMapper mapper = new ObjectMapper();
				 String url="/Sys/Func";
				 String jsonStrTemp = "{\"funType\": 2}";
				 OutputDataSearchBean testTableSearchBean = new OutputDataSearchBean();
				 String jsonStr = mapper.writeValueAsString(testTableSearchBean);
				 jsonStr = jsonStrTemp;
			     for(int i=0;i<RUN_COUNT;i++)
			     {
				      testPost(url,jsonStr);
			     }
			     printRunInfo(url,startTime);
			}
			
			/**
			 * 测试方法，资源管理根据设备名称获取品牌信息（内部）
			 * @throws Throwable
			 */
			@Test
			public void junitTestQueryYin51() throws Throwable
			{
				 Long startTime=new Date().getTime();
				 
				 ObjectMapper mapper = new ObjectMapper();
				 String url="/Issue?Action=queryEquBrand&id=239&pageSize=9000";
				 //String jsonStrTemp = "{\"funType\": 2}";
				 OutputDataSearchBean testTableSearchBean = new OutputDataSearchBean();
				 String jsonStr = mapper.writeValueAsString(testTableSearchBean);
				 //jsonStr = jsonStrTemp;
			     for(int i=0;i<RUN_COUNT;i++)
			     {
				      testGet(url,jsonStr);
			     }
			     printRunInfo(url,startTime);
			}
			
			/**
			 * 测试方法，资源管理根据品牌信息获取生产厂家（内部）
			 * @throws Throwable
			 */
			@Test
			public void junitTestQueryYin52() throws Throwable
			{
				 Long startTime=new Date().getTime();
				 
				 ObjectMapper mapper = new ObjectMapper();
				 String url="/Issue?Action=queryEquManufacturer&pageSize=9999";
				 //String jsonStrTemp = "{\"funType\": 2}";
				 OutputDataSearchBean testTableSearchBean = new OutputDataSearchBean();
				 String jsonStr = mapper.writeValueAsString(testTableSearchBean);
				 //jsonStr = jsonStrTemp;
			     for(int i=0;i<RUN_COUNT;i++)
			     {
				      testGet(url,jsonStr);
			     }
			     printRunInfo(url,startTime);
			}
			
			/**
			 * 测试方法，查询省
			 * @throws Throwable
			 */
			@Test
			public void junitTestQueryYin53() throws Throwable
			{
				 Long startTime=new Date().getTime();
				 
				 ObjectMapper mapper = new ObjectMapper();
				 String url="/Party/Region";
				 //String jsonStrTemp = "{\"funType\": 2}";
				 OutputDataSearchBean testTableSearchBean = new OutputDataSearchBean();
				 String jsonStr = mapper.writeValueAsString(testTableSearchBean);
				 //jsonStr = jsonStrTemp;
			     for(int i=0;i<RUN_COUNT;i++)
			     {
				      testPost(url,jsonStr);
			     }
			     printRunInfo(url,startTime);
			}
			
			/**
			 * 测试方法，机械设备分类查询-根据设备类型和设备名称来查询对应的结果集
			 * @throws Throwable
			 */
			@Test
			public void junitTestQueryYin54() throws Throwable
			{
				 Long startTime=new Date().getTime();
				 
				 ObjectMapper mapper = new ObjectMapper();
				 String url="/BG/Category?Action=ByEquCategoryName&class_=%E5%9C%9F%E7%9F%B3%E6%96%B9%E6%9C%BA%E6%A2%B0&equCategoryId=43&equNameId=239&pageNo=0&pageSize=20&randomTemp=850847&relationType=2";
				 //String jsonStrTemp = "{\"funType\": 2}";
				 OutputDataSearchBean testTableSearchBean = new OutputDataSearchBean();
				 String jsonStr = mapper.writeValueAsString(testTableSearchBean);
				 //jsonStr = jsonStrTemp;
			     for(int i=0;i<RUN_COUNT;i++)
			     {
				      testGet(url,jsonStr);
			     }
			     printRunInfo(url,startTime);
			}
			
			
			/**
			 * 测试方法，根据英文字母查询设备名称首字母相匹配的结果集
			 * @throws Throwable
			 */
			@Test
			public void junitTestQueryYin55() throws Throwable
			{
				 Long startTime=new Date().getTime();
				 
				 ObjectMapper mapper = new ObjectMapper();
				 String url="/Issue?Action=EquBrandFpy";
				 String jsonStrTemp = "{\"fpy\":[\"A\"]}";
				 OutputDataSearchBean testTableSearchBean = new OutputDataSearchBean();
				 String jsonStr = mapper.writeValueAsString(testTableSearchBean);
				 jsonStr = jsonStrTemp;
			     for(int i=0;i<RUN_COUNT;i++)
			     {
				      testPost(url,jsonStr);
			     }
			     printRunInfo(url,startTime);
			}
			
			/**
			 * 测试方法，根据品牌获取型号
			 * @throws Throwable
			 */
			@Test
			public void junitTestQueryYin56() throws Throwable
			{
				 Long startTime=new Date().getTime();
				 
				 ObjectMapper mapper = new ObjectMapper();
				 String url="/Issue?Action=queryEquModel&id=4&pageSize=9999";
//				 String jsonStrTemp = "{\"fpy\":[\"A\"]}";
				 OutputDataSearchBean testTableSearchBean = new OutputDataSearchBean();
				 String jsonStr = mapper.writeValueAsString(testTableSearchBean);
//				 jsonStr = jsonStrTemp;
			     for(int i=0;i<RUN_COUNT;i++)
			     {
				      testGet(url,jsonStr);
			     }
			     printRunInfo(url,startTime);
			}
			
			/**
			 * 测试方法，根据品牌获取规格
			 * @throws Throwable
			 */
			@Test
			public void junitTestQueryYin57() throws Throwable
			{
				 Long startTime=new Date().getTime();
				 
				 ObjectMapper mapper = new ObjectMapper();
				 String url="/Issue?Action=queryEquStandard&id=4&pageSize=9999";
//				 String jsonStrTemp = "{\"fpy\":[\"A\"]}";
				 OutputDataSearchBean testTableSearchBean = new OutputDataSearchBean();
				 String jsonStr = mapper.writeValueAsString(testTableSearchBean);
//				 jsonStr = jsonStrTemp;
			     for(int i=0;i<RUN_COUNT;i++)
			     {
				      testGet(url,jsonStr);
			     }
			     printRunInfo(url,startTime);
			}
			
			/**
			 * 测试方法，资源管理-添加模态框-外局租模糊查询
			 * @throws Throwable
			 */
			@Test
			public void junitTestQueryYin58() throws Throwable
			{
				 Long startTime=new Date().getTime();
				 
				 ObjectMapper mapper = new ObjectMapper();
				 String url="/BG/Party/Ent?Action=QueInnerEnts";
				 String jsonStrTemp = "{\"pageNo\": 0, \"pageSize\": 20, \"orgName\": \"1\"}";
				 OutputDataSearchBean testTableSearchBean = new OutputDataSearchBean();
				 String jsonStr = mapper.writeValueAsString(testTableSearchBean);
				 jsonStr = jsonStrTemp;
			     for(int i=0;i<RUN_COUNT;i++)
			     {
				      testPost(url,jsonStr);
			     }
			     printRunInfo(url,startTime);
			}
			
			
			/**
			 * 测试方法，根据省的id查询市的集合
			 * @throws Throwable
			 */
			@Test
			public void junitTestQueryYin59() throws Throwable
			{
				 Long startTime=new Date().getTime();
				 
				 ObjectMapper mapper = new ObjectMapper();
				 String url="/Party/Region";
				 String jsonStrTemp = "{\"regionId\": 36}";
				 OutputDataSearchBean testTableSearchBean = new OutputDataSearchBean();
				 String jsonStr = mapper.writeValueAsString(testTableSearchBean);
				 jsonStr = jsonStrTemp;
			     for(int i=0;i<RUN_COUNT;i++)
			     {
				      testPost(url,jsonStr);
			     }
			     printRunInfo(url,startTime);
			}
			
			
			/**
			 * 测试方法，根据市的id查询区的集合
			 * @throws Throwable
			 */
			@Test
			public void junitTestQueryYin60() throws Throwable
			{
				 Long startTime=new Date().getTime();
				 
				 ObjectMapper mapper = new ObjectMapper();
				 String url="/Party/Region";
				 String jsonStrTemp = "{\"regionId\": 77}";
				 OutputDataSearchBean testTableSearchBean = new OutputDataSearchBean();
				 String jsonStr = mapper.writeValueAsString(testTableSearchBean);
				 jsonStr = jsonStrTemp;
			     for(int i=0;i<RUN_COUNT;i++)
			     {
				      testPost(url,jsonStr);
			     }
			     printRunInfo(url,startTime);
			}
			
			/**
			 * 测试方法，设备名称去重复查询
			 * @throws Throwable
			 */
			@Test
			public void junitTestQueryYin61() throws Throwable
			{
				 Long startTime=new Date().getTime();
				 
				 ObjectMapper mapper = new ObjectMapper();
				 String url="/BG/Equipment?Action=GetEquName";
				 String jsonStrTemp = "{\"orgCode\": \"000000\"}";
				 OutputDataSearchBean testTableSearchBean = new OutputDataSearchBean();
				 String jsonStr = mapper.writeValueAsString(testTableSearchBean);
				 jsonStr = jsonStrTemp;
			     for(int i=0;i<RUN_COUNT;i++)
			     {
				      testPost(url,jsonStr);
			     }
			     printRunInfo(url,startTime);
			}
			
			/**
			 * 测试方法，获取设备所在单位的信息 
			 * @throws Throwable
			 */
			@Test
			public void junitTestQueryYin62() throws Throwable
			{
				 Long startTime=new Date().getTime();
				 
				 ObjectMapper mapper = new ObjectMapper();
				 String url="/BG/Equipment?Action=GetEquAtOrgName";
				 String jsonStrTemp = "{\"orgCode\": \"000000\"}";
				 OutputDataSearchBean testTableSearchBean = new OutputDataSearchBean();
				 String jsonStr = mapper.writeValueAsString(testTableSearchBean);
				 jsonStr = jsonStrTemp;
			     for(int i=0;i<RUN_COUNT;i++)
			     {
				      testPost(url,jsonStr);
			     }
			     printRunInfo(url,startTime);
			}
			
			/**
			 * 测试方法，外部资源管理查询设备编号是否重复
			 * @throws Throwable
			 */
			@Test
			public void junitTestQueryYin63() throws Throwable
			{
				 Long startTime=new Date().getTime();
				 
				 ObjectMapper mapper = new ObjectMapper();
				 String url="/BG/Equipment?Action=GetByEquNo&equNo=1";
				 //String jsonStrTemp = "{\"orgCode\": \"000000\"}";
				 OutputDataSearchBean testTableSearchBean = new OutputDataSearchBean();
				 String jsonStr = mapper.writeValueAsString(testTableSearchBean);
				 //jsonStr = jsonStrTemp;
			     for(int i=0;i<RUN_COUNT;i++)
			     {
				      testGet(url,jsonStr);
			     }
			     printRunInfo(url,startTime);
			}
			
			
			/**
			 * 测试方法，模糊查询所有企业信息
			 * @throws Throwable
			 */
			@Test
			public void junitTestQueryYin64() throws Throwable
			{
				 Long startTime=new Date().getTime();
				 
				 ObjectMapper mapper = new ObjectMapper();
				 String url="/BG/Party/Ent?Action=QueEnts";
				 String jsonStrTemp = "{\"pageNo\": 0, \"pageSize\": 20, \"orgName\": \"1\"}";
				 OutputDataSearchBean testTableSearchBean = new OutputDataSearchBean();
				 String jsonStr = mapper.writeValueAsString(testTableSearchBean);
				 jsonStr = jsonStrTemp;
			     for(int i=0;i<RUN_COUNT;i++)
			     {
				      testPost(url,jsonStr);
			     }
			     printRunInfo(url,startTime);
			}
			
			
			/**
			 * 测试方法，审核查询
			 * @throws Throwable
			 */
			@Test
			public void junitTestQueryYin65() throws Throwable
			{
				 Long startTime=new Date().getTime();
				 
				 ObjectMapper mapper = new ObjectMapper();
				 String url="/AUDIT/BusAuditInfo";
				 String jsonStrTemp = "{\"startReleaseDate\": \"2016-02-29\", \"endReleaseDate\": \"2016-03-30\", \"pageNo\": 0, \"pageSize\": 20}";
				 OutputDataSearchBean testTableSearchBean = new OutputDataSearchBean();
				 String jsonStr = mapper.writeValueAsString(testTableSearchBean);
				 jsonStr = jsonStrTemp;
			     for(int i=0;i<RUN_COUNT;i++)
			     {
				      testPost(url,jsonStr);
			     }
			     printRunInfo(url,startTime);
			}
			
			/**
			 * 测试方法，审核查看
			 * @throws Throwable
			 */
			@Test
			public void junitTestQueryYin66() throws Throwable
			{
				 Long startTime=new Date().getTime();
				 
				 ObjectMapper mapper = new ObjectMapper();
				 String url="/AUDIT/BusAuditInfo/121016";
//				 String jsonStrTemp = "{\"startReleaseDate\": \"2016-02-29\", \"endReleaseDate\": \"2016-03-30\", \"pageNo\": 0, \"pageSize\": 20}";
				 OutputDataSearchBean testTableSearchBean = new OutputDataSearchBean();
				 String jsonStr = mapper.writeValueAsString(testTableSearchBean);
//				 jsonStr = jsonStrTemp;
			     for(int i=0;i<RUN_COUNT;i++)
			     {
				      testGet(url,jsonStr);
			     }
			     printRunInfo(url,startTime);
			}
			
			/**
			 * 测试方法，信息审核查询
			 * @throws Throwable
			 */
			@Test
			public void junitTestQueryYin67() throws Throwable
			{
				 Long startTime=new Date().getTime();
				 
				 ObjectMapper mapper = new ObjectMapper();
				 String url="/AUDIT/BusAuditInfo";
				 String jsonStrTemp = "{\"startReleaseDate\": \"2016-02-29\", \"endReleaseDate\": \"2016-03-30\", \"pageNo\": 0, \"pageSize\": 20}";
				 OutputDataSearchBean testTableSearchBean = new OutputDataSearchBean();
				 String jsonStr = mapper.writeValueAsString(testTableSearchBean);
				 jsonStr = jsonStrTemp;
			     for(int i=0;i<RUN_COUNT;i++)
			     {
				      testPost(url,jsonStr);
			     }
			     printRunInfo(url,startTime);
			}
			
			/**
			 * 测试方法，信息审核-审核
			 * @throws Throwable
			 */
			@Test
			public void junitTestQueryYin68() throws Throwable
			{
				 Long startTime=new Date().getTime();
				 
				 ObjectMapper mapper = new ObjectMapper();
				 String url="/AUDIT/BusAuditInfo/122522";
				 //String jsonStrTemp = "{\"startReleaseDate\": \"2016-02-29\", \"endReleaseDate\": \"2016-03-30\", \"pageNo\": 0, \"pageSize\": 20, \"dataState\": 1}";
				 OutputDataSearchBean testTableSearchBean = new OutputDataSearchBean();
				 String jsonStr = mapper.writeValueAsString(testTableSearchBean);
				 //jsonStr = jsonStrTemp;
			     for(int i=0;i<RUN_COUNT;i++)
			     {
				      testGet(url,jsonStr);
			     }
			     printRunInfo(url,startTime);
			}

			/**
			 * 测试方法，获取热词搜索频率最高的记录集
			 * @throws Throwable
			 */
			@Test
			public void junitTestQueryYin69() throws Throwable
			{
				 Long startTime=new Date().getTime();
				 
				 ObjectMapper mapper = new ObjectMapper();
				 String url="/Issue?Action=SearchHotWords&pageNo=0&pageSize=5";
				 //String jsonStrTemp = "{\"startReleaseDate\": \"2016-02-29\", \"endReleaseDate\": \"2016-03-30\", \"pageNo\": 0, \"pageSize\": 20, \"dataState\": 1}";
				 OutputDataSearchBean testTableSearchBean = new OutputDataSearchBean();
				 String jsonStr = mapper.writeValueAsString(testTableSearchBean);
				 //jsonStr = jsonStrTemp;
			     for(int i=0;i<RUN_COUNT;i++)
			     {
				      testGet(url,jsonStr);
			     }
			     printRunInfo(url,startTime);
			}
			
			/**
			 * 测试方法，  最新出租设备信息查询
			 * @throws Throwable
			 */
			@Test
			public void junitTestQueryYin70() throws Throwable
			{
				 Long startTime=new Date().getTime();
				 
				 ObjectMapper mapper = new ObjectMapper();
				 String url="/Issue/122483?Action=Rent";
				 //String jsonStrTemp = "{\"startReleaseDate\": \"2016-02-29\", \"endReleaseDate\": \"2016-03-30\", \"pageNo\": 0, \"pageSize\": 20, \"dataState\": 1}";
				 OutputDataSearchBean testTableSearchBean = new OutputDataSearchBean();
				 String jsonStr = mapper.writeValueAsString(testTableSearchBean);
				 //jsonStr = jsonStrTemp;
			     for(int i=0;i<RUN_COUNT;i++)
			     {
				      testGet(url,jsonStr);
			     }
			     printRunInfo(url,startTime);
			}
			
			
			/**
			 * 测试方法，  最新出租单位基本资料
			 * @throws Throwable
			 */
			@Test
			public void junitTestQueryYin71() throws Throwable
			{
				 Long startTime=new Date().getTime();
				 
				 ObjectMapper mapper = new ObjectMapper();
				 String url="/Issue?Action=Rent";
				 //String jsonStrTemp = "{\"startReleaseDate\": \"2016-02-29\", \"endReleaseDate\": \"2016-03-30\", \"pageNo\": 0, \"pageSize\": 20, \"dataState\": 1}";
				 OutputDataSearchBean testTableSearchBean = new OutputDataSearchBean();
				 String jsonStr = mapper.writeValueAsString(testTableSearchBean);
				 //jsonStr = jsonStrTemp;
			     for(int i=0;i<RUN_COUNT;i++)
			     {
				      testPost(url,jsonStr);
			     }
			     printRunInfo(url,startTime);
			}
			
			/**
			 * 测试方法，  最新出租计算浏览次数
			 * @throws Throwable
			 */
			@Test
			public void junitTestQueryYin72() throws Throwable
			{
				 Long startTime=new Date().getTime();
				 
				 ObjectMapper mapper = new ObjectMapper();
				 String url="/Issue/122483";
				 //String jsonStrTemp = "{\"startReleaseDate\": \"2016-02-29\", \"endReleaseDate\": \"2016-03-30\", \"pageNo\": 0, \"pageSize\": 20, \"dataState\": 1}";
				 OutputDataSearchBean testTableSearchBean = new OutputDataSearchBean();
				 String jsonStr = mapper.writeValueAsString(testTableSearchBean);
				 //jsonStr = jsonStrTemp;
			     for(int i=0;i<RUN_COUNT;i++)
			     {
				      testGet(url,jsonStr);
			     }
			     printRunInfo(url,startTime);
			}
			
			
			/**
			 * 测试方法， 根据当前登录人和发布信息的ID，来判断当前登录人是否点击过我想交易的按钮
			 * @throws Throwable
			 */
			@Test
			public void junitTestQueryYin73() throws Throwable
			{
				 Long startTime=new Date().getTime();
				 
				 ObjectMapper mapper = new ObjectMapper();
				 String url="/Issue?Action=BusDealInfo&dataId=122483&loginUserId=3";
				 //String jsonStrTemp = "{\"startReleaseDate\": \"2016-02-29\", \"endReleaseDate\": \"2016-03-30\", \"pageNo\": 0, \"pageSize\": 20, \"dataState\": 1}";
				 OutputDataSearchBean testTableSearchBean = new OutputDataSearchBean();
				 String jsonStr = mapper.writeValueAsString(testTableSearchBean);
				 //jsonStr = jsonStrTemp;
			     for(int i=0;i<RUN_COUNT;i++)
			     {
				      testGet(url,jsonStr);
			     }
			     printRunInfo(url,startTime);
			}
			
			
			/**
			 * 测试方法， 出售信息明细查询
			 * @throws Throwable
			 */
			@Test
			public void junitTestQueryYin74() throws Throwable
			{
				 Long startTime=new Date().getTime();
				 
				 ObjectMapper mapper = new ObjectMapper();
				 String url="/Issue/121001?Action=Sale";
				 //String jsonStrTemp = "{\"startReleaseDate\": \"2016-02-29\", \"endReleaseDate\": \"2016-03-30\", \"pageNo\": 0, \"pageSize\": 20, \"dataState\": 1}";
				 OutputDataSearchBean testTableSearchBean = new OutputDataSearchBean();
				 String jsonStr = mapper.writeValueAsString(testTableSearchBean);
				 //jsonStr = jsonStrTemp;
			     for(int i=0;i<RUN_COUNT;i++)
			     {
				      testGet(url,jsonStr);
			     }
			     printRunInfo(url,startTime);
			}
			
			/**
			 * 测试方法， 前端出售搜索页面的查询方法
			 * @throws Throwable
			 */
			@Test
			public void junitTestQueryYin75() throws Throwable
			{
				 Long startTime=new Date().getTime();
				 
				 ObjectMapper mapper = new ObjectMapper();
				 String url="/Issue?Action=Sale";
				 //String jsonStrTemp = "{\"startReleaseDate\": \"2016-02-29\", \"endReleaseDate\": \"2016-03-30\", \"pageNo\": 0, \"pageSize\": 20, \"dataState\": 1}";
				 OutputDataSearchBean testTableSearchBean = new OutputDataSearchBean();
				 String jsonStr = mapper.writeValueAsString(testTableSearchBean);
				 //jsonStr = jsonStrTemp;
			     for(int i=0;i<RUN_COUNT;i++)
			     {
				      testPost(url,jsonStr);
			     }
			     printRunInfo(url,startTime);
			}
			
			
			
			/**
			 * 测试方法， 求租信息明细查询
			 * @throws Throwable
			 */
			@Test
			public void junitTestQueryYin76() throws Throwable
			{
				 Long startTime=new Date().getTime();
				 
				 ObjectMapper mapper = new ObjectMapper();
				 String url="/Issue/30990?Action=DemandRent";
				 //String jsonStrTemp = "{\"startReleaseDate\": \"2016-02-29\", \"endReleaseDate\": \"2016-03-30\", \"pageNo\": 0, \"pageSize\": 20, \"dataState\": 1}";
				 OutputDataSearchBean testTableSearchBean = new OutputDataSearchBean();
				 String jsonStr = mapper.writeValueAsString(testTableSearchBean);
				 //jsonStr = jsonStrTemp;
			     for(int i=0;i<RUN_COUNT;i++)
			     {
				      testGet(url,jsonStr);
			     }
			     printRunInfo(url,startTime);
			}
			
			/**
			 * 测试方法，前端求租搜索页面的查询方法
			 * @throws Throwable
			 */
			@Test
			public void junitTestQueryYin77() throws Throwable
			{
				 Long startTime=new Date().getTime();
				 
				 ObjectMapper mapper = new ObjectMapper();
				 String url="/Issue?Action=DemandRent";
				 //String jsonStrTemp = "{\"startReleaseDate\": \"2016-02-29\", \"endReleaseDate\": \"2016-03-30\", \"pageNo\": 0, \"pageSize\": 20, \"dataState\": 1}";
				 OutputDataSearchBean testTableSearchBean = new OutputDataSearchBean();
				 String jsonStr = mapper.writeValueAsString(testTableSearchBean);
				 //jsonStr = jsonStrTemp;
			     for(int i=0;i<RUN_COUNT;i++)
			     {
				      testPost(url,jsonStr);
			     }
			     printRunInfo(url,startTime);
			}
			
			/**
			 * 测试方法，求购信息明细查询
			 * @throws Throwable
			 */
			@Test
			public void junitTestQueryYin78() throws Throwable
			{
				 Long startTime=new Date().getTime();
				 
				 ObjectMapper mapper = new ObjectMapper();
				 String url="/Issue/60928?Action=DemandSale";
				 //String jsonStrTemp = "{\"startReleaseDate\": \"2016-02-29\", \"endReleaseDate\": \"2016-03-30\", \"pageNo\": 0, \"pageSize\": 20, \"dataState\": 1}";
				 OutputDataSearchBean testTableSearchBean = new OutputDataSearchBean();
				 String jsonStr = mapper.writeValueAsString(testTableSearchBean);
				 //jsonStr = jsonStrTemp;
			     for(int i=0;i<RUN_COUNT;i++)
			     {
				      testGet(url,jsonStr);
			     }
			     printRunInfo(url,startTime);
			}
			
	
			
			/**
			 * 测试方法，前端求购搜索页面的查询方法
			 * @throws Throwable
			 */
			@Test
			public void junitTestQueryYin80() throws Throwable
			{
				 Long startTime=new Date().getTime();
				 
				 ObjectMapper mapper = new ObjectMapper();
				 String url="/Issue?Action=DemandSale";
				 //String jsonStrTemp = "{\"startReleaseDate\": \"2016-02-29\", \"endReleaseDate\": \"2016-03-30\", \"pageNo\": 0, \"pageSize\": 20, \"dataState\": 1}";
				 OutputDataSearchBean testTableSearchBean = new OutputDataSearchBean();
				 String jsonStr = mapper.writeValueAsString(testTableSearchBean);
				 //jsonStr = jsonStrTemp;
			     for(int i=0;i<RUN_COUNT;i++)
			     {
				      testPost(url,jsonStr);
			     }
			     printRunInfo(url,startTime);
			}
			
			
			/**
			 * 测试方法，根据英文字母查询设备名称首字母相匹配的结果集
			 * @throws Throwable
			 */
			@Test
			public void junitTestQueryYin81() throws Throwable
			{
				 Long startTime=new Date().getTime();
				 
				 ObjectMapper mapper = new ObjectMapper();
				 String url="/Issue?Action=EquNameFpy";
				 String jsonStrTemp = "{\"fpy\": [\"A\", \"B\", \"C\", \"D\"]}";
				 OutputDataSearchBean testTableSearchBean = new OutputDataSearchBean();
				 String jsonStr = mapper.writeValueAsString(testTableSearchBean);
				 jsonStr = jsonStrTemp;
			     for(int i=0;i<RUN_COUNT;i++)
			     {
				      testPost(url,jsonStr);
			     }
			     printRunInfo(url,startTime);
			}
			
			/**
			 * 测试方法，查询对应的视图，获取当前登录人我已发布的信息
			 * @throws Throwable
			 */
			@Test
			public void junitTestQueryYin82() throws Throwable
			{
				 Long startTime=new Date().getTime();
				 
				 ObjectMapper mapper = new ObjectMapper();
				 String url="/BG/BusPublishInfo";
				 String jsonStrTemp = "{\"pageNo\": 0, \"pageSize\": 10, \"startReleaseDate\": \"2016-02-29\", \"endReleaseDate\": \"2016-03-31\"}";
				 OutputDataSearchBean testTableSearchBean = new OutputDataSearchBean();
				 String jsonStr = mapper.writeValueAsString(testTableSearchBean);
				 jsonStr = jsonStrTemp;
			     for(int i=0;i<RUN_COUNT;i++)
			     {
				      testPost(url,jsonStr);
			     }
			     printRunInfo(url,startTime);
			}
			
			/**
			 * 测试方法，查询对应的视图，获取当前登录人我想交易的信息
			 * @throws Throwable
			 */
			@Test
			public void junitTestQueryYin83() throws Throwable
			{
				 Long startTime=new Date().getTime();
				 
				 ObjectMapper mapper = new ObjectMapper();
				 String url="/BG/BusDealInfo";
				 String jsonStrTemp = "{\"pageNo\": 0, \"pageSize\": 10, \"startReleaseDate\": \"2016-02-29\", \"endReleaseDate\": \"2016-03-31\"}";
				 OutputDataSearchBean testTableSearchBean = new OutputDataSearchBean();
				 String jsonStr = mapper.writeValueAsString(testTableSearchBean);
				 jsonStr = jsonStrTemp;
			     for(int i=0;i<RUN_COUNT;i++)
			     {
				      testPost(url,jsonStr);
			     }
			     printRunInfo(url,startTime);
			}
			
			/**
			 * 测试方法，首页搜索设备信息输入框，输入信息后展示对应搜索信息
			 * @throws Throwable
			 */
			@Test
			public void junitTestQueryYin84() throws Throwable
			{
				 Long startTime=new Date().getTime();
				 
				 ObjectMapper mapper = new ObjectMapper();
				 String url="/Issue?Action=ITCount&infoTitle=11&infoType=2";
				 //String jsonStrTemp = "{\"pageNo\": 0, \"pageSize\": 10, \"startReleaseDate\": \"2016-02-29\", \"endReleaseDate\": \"2016-03-31\"}";
				 OutputDataSearchBean testTableSearchBean = new OutputDataSearchBean();
				 String jsonStr = mapper.writeValueAsString(testTableSearchBean);
				 //jsonStr = jsonStrTemp;
			     for(int i=0;i<RUN_COUNT;i++)
			     {
				      testGet(url,jsonStr);
			     }
			     printRunInfo(url,startTime);
			}
			
			
			
//===================================================================================================================================================================			
			
			
			
			
			/**
			 * 测试方法，查询企业列表
			 * @throws Throwable
			 */
			@Test
			public void junitTest7() throws Throwable
			{
				 Long startTime=new Date().getTime();
				 
				 ObjectMapper mapper = new ObjectMapper();
				 String url="/BG/Party/Ent";
				 OutputDataSearchBean testTableSearchBean = new OutputDataSearchBean();
				 String jsonStr = mapper.writeValueAsString(testTableSearchBean);
				 
				 String jsonStrTemp="{\"currOrgId\":\"1\",\"pageNo\":0,\"pageSize\":10}";

				 jsonStr=jsonStrTemp;
			     for(int i=0;i<RUN_COUNT;i++)
			     {
				      testPost(url,jsonStr);
			     }
			     printRunInfo(url,startTime);
			}
			
			
			/**
			 * 测试方法，添加企业
			 * @throws Throwable
			 */
			@Test
			public void junitTestAddEntByQian() throws Throwable
			{
				 Long startTime=new Date().getTime();
				 
				 ObjectMapper mapper = new ObjectMapper();
				 String url="/BG/Party/Ent";
				 OutputDataSearchBean testTableSearchBean = new OutputDataSearchBean();
				 String jsonStr = mapper.writeValueAsString(testTableSearchBean);
				 
				 String jsonStrTemp="{\"code\":\"000xxx\",\"parentCode\":\"000\",\"name\":\"中铁\",\"orgLevel\":\"2\",\"note\":\"test\",\"parentOrgId\":\"1\"}";
				 Map objMap=BeanUtil.toObjectFromJson(jsonStrTemp, Map.class);
			     for(int i=0;i<RUN_COUNT;i++)
			     {
			    	 objMap.put("name", "企业"+new Date().getTime());
			    	 jsonStr=BeanUtil.toJsonString(objMap);
				      testPut(url,jsonStr);
			     }
			     printRunInfo(url,startTime);
			}
			
			/**
			 * 测试方法，修改企业
			 * @throws Throwable
			 */
			@Test
			public void junitTestUpdEntByQian() throws Throwable
			{
				 Long startTime=new Date().getTime();
				 
				 ObjectMapper mapper = new ObjectMapper();
				 
				 String url="/BG/Party/Ent/4566";
				 OutputDataSearchBean testTableSearchBean = new OutputDataSearchBean();
				 String jsonStr = mapper.writeValueAsString(testTableSearchBean);
				 
				 String jsonStrTemp="{\"parentOrgName\":\"总公司\",\"name\":\"企业1459331147503\",\"parentOrgId\":1,\"code\":\"000357\",\"parentParentCode\":\"0\",\"parentCode\":\"000\",\"parentOrgLevel\":1,\"note\":\"test\",\"orgLevel\":2,\"orgParentCode\":\"000\"}";
				 Map objMap=BeanUtil.toObjectFromJson(jsonStrTemp, Map.class);
			     for(int i=0;i<RUN_COUNT;i++)
			     {
			    	 objMap.put("name", "企业"+new Date().getTime());
			    	 jsonStr=BeanUtil.toJsonString(objMap);
				      testPost(url,jsonStr);
			     }
			     printRunInfo(url,startTime);
			}

			/**
			 * 测试方法，添加员工
			 * @throws Throwable
			 */
			@Test
			public void junitTestAddPerByQian() throws Throwable
			{
				 Long startTime=new Date().getTime();
				 
				 ObjectMapper mapper = new ObjectMapper();
				 
				 OutputDataSearchBean testTableSearchBean = new OutputDataSearchBean();
				 String jsonStr = mapper.writeValueAsString(testTableSearchBean);
				 
				 String url="/BG/Party/Per";
				 String jsonStrTemp="{\"orgName\":\"\",\"mobile\":\"18700000000\",\"phoneNo\":\"\",\"mail\":\"null\",\"orgNameCopy\":\"总公司\",\"loginId\":\"runtong\",\"name\":\"xiaoqiang\",\"code\":\"xiaoqiang01\",\"funInfo\":[],\"deptId\":\"1\",\"email\":\"\",\"uploadFileInfo\":[]}";
				 Map objMap=BeanUtil.toObjectFromJson(jsonStrTemp, Map.class);
			     for(int i=0;i<RUN_COUNT;i++)
			     {
			    	 objMap.put("loginId", "runtong"+new Date().getTime());
			    	 jsonStr=BeanUtil.toJsonString(objMap);
				      testPut(url,jsonStr);
			     }
			     printRunInfo(url,startTime);
			}
	
			/**
			 * 测试方法，修改员工
			 * @throws Throwable
			 */
			@Test
			public void junitTestUpdPerByQian() throws Throwable
			{
				 Long startTime=new Date().getTime();
				 
				 ObjectMapper mapper = new ObjectMapper();
				 
				 OutputDataSearchBean testTableSearchBean = new OutputDataSearchBean();
				 String jsonStr = mapper.writeValueAsString(testTableSearchBean);
				 
				 String url="/BG/Party/Per/2233";
				 String jsonStrTemp="{\"proId\":\"\",\"deptName\":\"总公司\",\"funInfo\":[],\"mail\":\"null\",\"loginId\":\"runtong1459244560549\",\"uploadFileInfo\":[],\"updateTime\":\"2016-03-29 17:42:41\",\"state\":0,\"uId\":null,\"admFlag\":null,\"parTypeId\":3,\"code\":\"xiaoqiang01\",\"phoneNo\":\"\",\"proName\":\"\",\"partyId\":2233,\"email\":\"\",\"name\":\"xiaoqiang\",\"deptId\":1,\"note\":null,\"qq\":null,\"openId\":null,\"mobile\":\"18700000000\",\"authLv\":null,\"loginId_Copy\":\"runtong1459244560549\",\"loginUId\":null}";
				 Map objMap=BeanUtil.toObjectFromJson(jsonStrTemp, Map.class);
			     for(int i=0;i<RUN_COUNT;i++)
			     {
			    	 objMap.put("loginId", "runtong"+new Date().getTime());
			    	 jsonStr=BeanUtil.toJsonString(objMap);
				      testPost(url,jsonStr);
			     }
			     printRunInfo(url,startTime);
			}
			
	
			/**
			 * 测试方法，添加外部供应商
			 * @throws Throwable
			 */
			@Test
			public void junitTestAddProviderByQian() throws Throwable
			{
				 Long startTime=new Date().getTime();
				 
				 ObjectMapper mapper = new ObjectMapper();
				 
				 OutputDataSearchBean testTableSearchBean = new OutputDataSearchBean();
				 String jsonStr = mapper.writeValueAsString(testTableSearchBean);
		
				 String url="/BG/Party/Provider"; 
				 String jsonStrTemp="{\"mobile\":\"18700000000\",\"orgName\":\"zs商务公司\",\"mail\":\"zs001AAAAAAAA@vip.qq.com\",\"phoneNo\":\"18765613131\",\"loginId\":\"zs001\",\"deptName\":\"zs商务公司\",\"name\":\"zs0\",\"code\":\"zs0\",\"funInfo\":[{\"functionId\":10},{\"functionId\":11},{\"functionId\":12},{\"functionId\":13},{\"functionId\":14},{\"functionId\":17}],\"email\":\"\",\"uploadFileInfo\":[]}";
				 Map objMap=BeanUtil.toObjectFromJson(jsonStrTemp, Map.class);
			     for(int i=0;i<RUN_COUNT;i++)
			     {
			    	 objMap.put("loginId", "外部供应商"+new Date().getTime());
			    	 jsonStr=BeanUtil.toJsonString(objMap);
				      testPut(url,jsonStr);
			     }
			     printRunInfo(url,startTime);
			}
			
			/**
			 * 测试方法，修改外部供应商
			 * @throws Throwable
			 */
			@Test
			public void junitTestUpdProviderByQian() throws Throwable
			{
				 Long startTime=new Date().getTime();
				 
				 ObjectMapper mapper = new ObjectMapper();
				 
				 OutputDataSearchBean testTableSearchBean = new OutputDataSearchBean();
				 String jsonStr = mapper.writeValueAsString(testTableSearchBean);
		
				 String url="/BG/Party/Provider/2790"; 
				 String jsonStrTemp="{\"deptName\":\"zs商务公司\",\"funInfo\":[{\"functionId\":10},{\"functionId\":11},{\"functionId\":12},{\"functionId\":13},{\"functionId\":14},{\"functionId\":17}],\"mail\":\"zs001AAAAAAAA@vip.qq.com\",\"loginId\":\"外部供应商1459244569617\",\"updateTime\":\"2016-03-29 17:42:50\",\"state\":0,\"uId\":null,\"parTypeId\":3,\"code\":\"zs0\",\"phoneNo\":\"18765613131\",\"partyId\":2790,\"email\":\"\",\"name\":\"zs0\",\"deptId\":329,\"note\":null,\"qq\":null,\"openId\":null,\"mobile\":\"18700000000\",\"authLv\":null,\"loginId_Copy\":\"外部供应商1459244569617\",\"loginUId\":null,\"uploadFileInfo\":[],\"orgName\":\"zs商务公司\"}";
				 Map objMap=BeanUtil.toObjectFromJson(jsonStrTemp, Map.class);
			     for(int i=0;i<RUN_COUNT;i++)
			     {
			    	 objMap.put("loginId", "外部供应商"+new Date().getTime());
			    	 jsonStr=BeanUtil.toJsonString(objMap);
				      testPost(url,jsonStr);
			     }
			     printRunInfo(url,startTime);
			}

			/**
			 * 测试方法，添加设备名称，小类名称
			 * @throws Throwable
			 */
			@Test
			public void junitTestAddEquNameByQian() throws Throwable
			{
				 Long startTime=new Date().getTime();
				 
				 ObjectMapper mapper = new ObjectMapper();
				 OutputDataSearchBean testTableSearchBean = new OutputDataSearchBean();
				 String jsonStr = mapper.writeValueAsString(testTableSearchBean);
				 
				 String url="/BG/Category?Action=EquName"; 
				 String jsonStrTemp="{\"equipmentNo\":\"10000\",\"equCategoryId\":43,\"equipmentName\":\"test\",\"second\":\"1\"}";
				 Map objMap=BeanUtil.toObjectFromJson(jsonStrTemp, Map.class);
			     for(int i=0;i<RUN_COUNT;i++)
			     {
			    	 objMap.put("equipmentNo","equNo"+Math.round((Math.random()*1000)));
			    	 objMap.put("equipmentName","equName"+Math.round((Math.random()*1000)));
			    	 jsonStr=BeanUtil.toJsonString(objMap);
				      testPut(url,jsonStr);
			     }
			     printRunInfo(url,startTime);
			}
	
			/**
			 * 测试方法，修改设备名称，小类名称
			 * @throws Throwable
			 */
			@Test
			public void junitTestUpdEquNameByQian() throws Throwable
			{
				 Long startTime=new Date().getTime();
				 
				 ObjectMapper mapper = new ObjectMapper();
				 OutputDataSearchBean testTableSearchBean = new OutputDataSearchBean();
				 String jsonStr = mapper.writeValueAsString(testTableSearchBean);
				 
				 String url="/BG/Category/286?Action=EquName"; 
				 String jsonStrTemp="{\"equNameId\":286,\"equipmentNo\":\"10201\",\"equipmentName\":\"电动空压机\",\"second\":\"1\",\"searchCount\":0,\"objectId\":286,\"equCategoryId\":44}";
				 Map objMap=BeanUtil.toObjectFromJson(jsonStrTemp, Map.class);
			     for(int i=0;i<RUN_COUNT;i++)
			     {
			    	 objMap.put("equipmentNo","equNo"+Math.round((Math.random()*1000)));
			    	 objMap.put("equipmentName","equName"+Math.round((Math.random()*1000)));
			    	 jsonStr=BeanUtil.toJsonString(objMap);
				      testPost(url,jsonStr);
			     }
			     printRunInfo(url,startTime);
			}
			
			
			/**
			 * 测试方法，添加设备名称，大类名称
			 * @throws Throwable
			 */
			@Test
			public void junitTestAddEquCategoryByQian() throws Throwable
			{
				 Long startTime=new Date().getTime();
				 
				 ObjectMapper mapper = new ObjectMapper();
				 OutputDataSearchBean testTableSearchBean = new OutputDataSearchBean();
				 String jsonStr = mapper.writeValueAsString(testTableSearchBean);
				 
				 String url="/BG/Category?Action=EquCategory";
				 String jsonStrTemp="{\"equipmentCategoryNo\":\"tt\",\"equipmentCategoryName\":\"tt\"}";
				 
				 Map objMap=BeanUtil.toObjectFromJson(jsonStrTemp, Map.class);
			     for(int i=0;i<RUN_COUNT;i++)
			     {
			    	 objMap.put("equipmentCategoryNo","no"+Math.round((Math.random()*1000)));
			    	 objMap.put("equipmentCategoryName","name"+Math.round((Math.random()*1000)));
			    	 jsonStr=BeanUtil.toJsonString(objMap);
				      testPut(url,jsonStr);
			     }
			     printRunInfo(url,startTime);
			}
			
			/**
			 * 测试方法，修改设备名称，大类名称
			 * @throws Throwable
			 */
			@Test
			public void junitTestUpdEquCategoryByQian() throws Throwable
			{
				 Long startTime=new Date().getTime();
				 
				 ObjectMapper mapper = new ObjectMapper();
				 OutputDataSearchBean testTableSearchBean = new OutputDataSearchBean();
				 String jsonStr = mapper.writeValueAsString(testTableSearchBean);
				 
				 String url="/BG/Category/43?Action=EquCategory";
				 String jsonStrTemp="{\"equCategoryId\":43,\"equipmentCategoryNo\":\"101\",\"equipmentCategoryName\":\"土石方机械\",\"objectId\":43}";
				 
				 Map objMap=BeanUtil.toObjectFromJson(jsonStrTemp, Map.class);
			     for(int i=0;i<RUN_COUNT;i++)
			     {
			    	 objMap.put("equipmentCategoryNo","no"+Math.round((Math.random()*1000)));
			    	 objMap.put("equipmentCategoryName","name"+Math.round((Math.random()*1000)));
			    	 jsonStr=BeanUtil.toJsonString(objMap);
				      testPost(url,jsonStr);
			     }
			     printRunInfo(url,startTime);
			}
	
			
			/**
			 * 测试方法，添加设备名称，添加设备分类，大类和小类的组合构成的
			 * @throws Throwable
			 */
			@Test
			public void junitTestAddCategoryByQian() throws Throwable
			{
				 Long startTime=new Date().getTime();
				 
				 ObjectMapper mapper = new ObjectMapper();
				 OutputDataSearchBean testTableSearchBean = new OutputDataSearchBean();
				 String jsonStr = mapper.writeValueAsString(testTableSearchBean);
				 
				 String url="/BG/Category";
				 		 
				 String jsonStrTemp="{\"typeNo\":\"tt\",\"equCategoryId\":43,\"equipmentCategoryName\":\"土石方机械\",\"equNameId\":239}";
				 
				 Map objMap=BeanUtil.toObjectFromJson(jsonStrTemp, Map.class);
			     for(int i=0;i<RUN_COUNT;i++)
			     {
			    	 objMap.put("typeNo","no"+Math.round((Math.random()*1000)));
			    	 jsonStr=BeanUtil.toJsonString(objMap);
				      testPut(url,jsonStr);
			     }
			     printRunInfo(url,startTime);
			}
	
			
			/**
			 * 测试方法，修改设备名称，添加设备分类，大类和小类的组合构成的
			 * @throws Throwable
			 */
			@Test
			public void junitTestUpdCategoryByQian() throws Throwable
			{
				 Long startTime=new Date().getTime();
				 
				 ObjectMapper mapper = new ObjectMapper();
				 OutputDataSearchBean testTableSearchBean = new OutputDataSearchBean();
				 String jsonStr = mapper.writeValueAsString(testTableSearchBean);
				 
				 String url="/BG/Category/1894";
				 		 
				 String jsonStrTemp="{\"categoryId\":1894,\"relationType\":2,\"typeNo\":\"no409\",\"equCategoryId\":43,\"equNameId\":239}";
				 
				 Map objMap=BeanUtil.toObjectFromJson(jsonStrTemp, Map.class);
			     for(int i=0;i<RUN_COUNT;i++)
			     {
			    	 objMap.put("typeNo","no"+Math.round((Math.random()*1000)));
			    	 jsonStr=BeanUtil.toJsonString(objMap);
				      testPost(url,jsonStr);
			     }
			     printRunInfo(url,startTime);
			}
			
	
			/**
			 * 测试方法，添加项目
			 * @throws Throwable
			 */
			@Test
			public void junitTestAddProByQian() throws Throwable
			{
				 Long startTime=new Date().getTime();
				 
				 ObjectMapper mapper = new ObjectMapper();
				 OutputDataSearchBean testTableSearchBean = new OutputDataSearchBean();
				 String jsonStr = mapper.writeValueAsString(testTableSearchBean);
				 
				 String url="/BG/Party/Pro";
				 		 
				 String jsonStrTemp="{\"parentCode\":\"000000\",\"code\":\"11\",\"name\":\"11\",\"note\":\"\",\"parentOrgId\":\"318\"}";
				 
				 Map objMap=BeanUtil.toObjectFromJson(jsonStrTemp, Map.class);
			     for(int i=0;i<RUN_COUNT;i++)
			     {
			    	 objMap.put("code","code"+new Date().getTime());
			    	 objMap.put("name","name"+new Date().getTime());
			    	 jsonStr=BeanUtil.toJsonString(objMap);
				      testPut(url,jsonStr);
			     }
			     printRunInfo(url,startTime);
			}
			
			/**
			 * 测试方法，修改项目
			 * @throws Throwable
			 */
			@Test
			public void junitTestUpdProByQian() throws Throwable
			{
				 Long startTime=new Date().getTime();
				 
				 ObjectMapper mapper = new ObjectMapper();
				 OutputDataSearchBean testTableSearchBean = new OutputDataSearchBean();
				 String jsonStr = mapper.writeValueAsString(testTableSearchBean);
				 
				 String url="/BG/Party/Pro/323";
				 		 
				 String jsonStrTemp="{\"parentOrgName\":\"中铁一局一处\",\"name\":\"中铁一局一处1\",\"parentOrgId\":322,\"state\":0,\"code\":\"011\",\"parentCode\":\"000000000\",\"note\":\"中铁一局一处1\",\"parTypeId\":4}";
				 
				 Map objMap=BeanUtil.toObjectFromJson(jsonStrTemp, Map.class);
			     for(int i=0;i<RUN_COUNT;i++)
			     {
			    	 objMap.put("code","code"+new Date().getTime());
			    	 objMap.put("name","name"+new Date().getTime());
			    	 jsonStr=BeanUtil.toJsonString(objMap);
				      testPost(url,jsonStr);
			     }
			     printRunInfo(url,startTime);
			}


			/**
			 * 测试方法，添加设备
			 * @throws Throwable
			 */
			@Test
			public void junitTestAddEquByQian() throws Throwable
			{
				 Long startTime=new Date().getTime();
				 
				 ObjectMapper mapper = new ObjectMapper();
				 OutputDataSearchBean testTableSearchBean = new OutputDataSearchBean();
				 String jsonStr = mapper.writeValueAsString(testTableSearchBean);
				
				 
				 String url="/BG/Equipment";
				 		 
				 String jsonStrTemp="{\"releaseState\":\"1\",\"rentType_\":\"1\",\"pubState\":\"1\",\"equipmentCategoryTable\":{\"0\":{\"categoryTable\":{}}},\"leaseModeName\":\"\",\"settlementModeName\":\"\",\"projectName\":\"name1459245494233\",\"projectId\":3705,\"undefined\":3705,\"subsidiaryName\":\"中铁一局一处\",\"currOrgId\":322,\"subsidiaryId\":322,\"equNo\":\"se\",\"categoryId\":857,\"copyId\":857,\"equNameId\":290,\"brandNo\":1,\"brandNoCopy\":1,\"brandName\":\"安迈\",\"manufacturer\":\"北京松源华兴生物技术有限公司\",\"manufacturerId\":13,\"busState\":\"2\",\"equAtOrgName\":\"\",\"leasePrice\":\"\",\"contractNo\":\"\",\"remark\":\"\",\"equipmentSourceNo\":\"1\",\"equState\":\"2\",\"onProvince\":\"北京\",\"onCity\":\"北京市\",\"onDistrict\":\"朝阳区\",\"contactPersonPhone\":\"18799999999\",\"partyId\":\"318\",\"bureauId\":\"318\"}";
				 
				 Map objMap=BeanUtil.toObjectFromJson(jsonStrTemp, Map.class);
			     for(int i=0;i<RUN_COUNT;i++)
			     {
			    	 objMap.put("code","code"+new Date().getTime());
			    	 objMap.put("name","name"+new Date().getTime());
			    	 jsonStr=BeanUtil.toJsonString(objMap);
				      testPut(url,jsonStr);
			     }
			     printRunInfo(url,startTime);
			}
			
			
			/**
			 * 测试方法，修改设备
			 * @throws Throwable
			 */
			@Test
			public void junitTestUpdEquByQian() throws Throwable
			{
				 Long startTime=new Date().getTime();
				 
				 ObjectMapper mapper = new ObjectMapper();
				 OutputDataSearchBean testTableSearchBean = new OutputDataSearchBean();
				 String jsonStr = mapper.writeValueAsString(testTableSearchBean);
				
				 
				 String url="/BG/Equipment/61881";
				 		 
				 String jsonStrTemp="{\"bureauId\":\"318\",\"subsidiaryId\":322,\"projectId\":320,\"equNo\":\"111111\",\"asset\":\"111111\",\"equipmentCategoryTable\":[{\"equipmentCategoryId\":5,\"equipmentId\":61881,\"categoryTable\":{\"categoryId\":857,\"equCategory\":{\"equCategoryId\":44,\"equipmentCategoryNo\":\"102\",\"equipmentCategoryName\":\"动力机械\",\"objectId\":44},\"equName\":{\"equNameId\":290,\"equipmentNo\":\"10202\",\"equipmentName\":\"发电船\",\"second\":null,\"searchCount\":2,\"objectId\":290},\"typeNo\":\"100\",\"relationType\":2}}],\"brandNo\":\"1\",\"brandName\":\"安迈\",\"manufacturerId\":1,\"manufacturer\":\"常州继豪电子有限公司\",\"productionDate\":\"2016-03-17\",\"facortyNo\":\"11111\",\"modelsId\":\"1\",\"models\":\"增强型\",\"specificationsId\":1,\"specifications\":\"大箱子\",\"powerId\":99999,\"power\":1111,\"equAtOrgId\":null,\"equAtOrgName\":\"\",\"equipmentCost\":\"111\",\"purchaseDate\":\"2016-03-17\",\"technicalStatus\":\"1\",\"licenseNo\":\"1111\",\"powerType\":\"1\",\"equipmentSourceNo\":\"1\",\"equipmentSourceName\":\"11111111\",\"equState\":\"2\",\"rentFlag\":1,\"saleFlag\":1,\"busState\":\"2\",\"pubState\":\"2\",\"atCity\":null,\"onProvince\":\"福建省\",\"onCity\":\"福州市\",\"onDistrict\":\"鼓楼区\",\"address\":\"1111\",\"custodian\":\"11111\",\"contactPersonPhone\":\"18200000000\",\"approachDate\":\"2016-03-17\",\"exitDate\":\"2016-03-25\",\"leaseModeNo\":null,\"leaseModeName\":\"1\",\"leasePrice\":null,\"settlementModeNo\":null,\"settlementModeName\":\"1\",\"contractNo\":\"\",\"remark\":\"\",\"equipmentAscriptionTable\":[{\"equipmentAscriptionId\":3,\"equipmentId\":61881,\"party\":{\"partyId\":318,\"parType\":{\"parTypeId\":4,\"note\":\"企业\",\"name\":\"企业\",\"objectId\":4},\"region\":null,\"createTime\":\"2016-03-17 03:14:27\",\"updateTime\":\"2016-03-17 03:14:27\",\"note\":\"中铁一局\",\"state\":0,\"budget\":null,\"code\":\"000000\",\"name\":\"中铁一局\",\"offAddr\":null,\"zip\":null,\"phone\":null,\"fax\":null,\"type\":null,\"contacts\":null,\"contactsMobile\":null,\"contactsEmail\":null,\"orgLevel\":2,\"parentCode\":\"000\",\"objectId\":318},\"objectId\":61881}],\"equipmentId\":61881,\"delFlag\":0,\"delDate\":null,\"quantity\":null,\"origin\":null,\"specialNo\":null,\"rentalUnit\":null,\"impExpFee\":null,\"subsidiaryName\":\"中铁一局一处\",\"projectName\":\"中铁一局1\",\"categoryId\":857,\"partyId\":\"318\"}";
				 
				 Map objMap=BeanUtil.toObjectFromJson(jsonStrTemp, Map.class);
			     for(int i=0;i<RUN_COUNT;i++)
			     {
			    	 objMap.put("code","code"+new Date().getTime());
			    	 objMap.put("name","name"+new Date().getTime());
			    	 jsonStr=BeanUtil.toJsonString(objMap);
				      testPost(url,jsonStr);
			     }
			     printRunInfo(url,startTime);
			}
			
			/**
			 * 测试方法，修改设备——使用情况完成
			 * @throws Throwable
			 */
			@Test
			public void junitTestAddUseInfoByQian() throws Throwable
			{
				 Long startTime=new Date().getTime();
				 
				 ObjectMapper mapper = new ObjectMapper();
				 OutputDataSearchBean testTableSearchBean = new OutputDataSearchBean();
				 String jsonStr = mapper.writeValueAsString(testTableSearchBean);
				
				 
				 String url="/BG/Equipment?Action=AddUseInfo";
				 		 
				 String jsonStrTemp="{\"bureauId\":318,\"subsidiaryId\":322,\"projectId\":320,\"equNo\":\"111111\",\"asset\":\"111111\",\"equipmentCategoryTable\":[{\"equipmentCategoryId\":30952,\"equipmentId\":3,\"categoryTable\":{\"categoryId\":857,\"equCategory\":{\"equCategoryId\":44,\"equipmentCategoryNo\":\"102\",\"equipmentCategoryName\":\"动力机械\",\"objectId\":44},\"equName\":{\"equNameId\":290,\"equipmentNo\":\"10202\",\"equipmentName\":\"发电船\",\"second\":null,\"searchCount\":2,\"objectId\":290},\"typeNo\":\"100\",\"relationType\":2}}],\"brandNo\":\"1\",\"brandName\":\"安迈\",\"manufacturerId\":1,\"manufacturer\":\"常州继豪电子有限公司\",\"productionDate\":\"2016-03-17\",\"facortyNo\":\"11111\",\"modelsId\":\"1\",\"models\":\"增强型\",\"specificationsId\":1,\"specifications\":\"大箱子\",\"powerId\":99999,\"power\":1111,\"equAtOrgId\":\"318\",\"equAtOrgName\":\"中铁一局\",\"equipmentCost\":\"111\",\"purchaseDate\":\"2016-03-17\",\"technicalStatus\":\"1\",\"licenseNo\":\"1111\",\"powerType\":\"1\",\"equipmentSourceNo\":\"1\",\"equipmentSourceName\":\"11111111\",\"equState\":\"2\",\"rentFlag\":\"\",\"saleFlag\":\"\",\"busState\":\"1\",\"pubState\":\"1\",\"atCity\":null,\"onProvince\":\"福建省\",\"onCity\":\"福州市\",\"onDistrict\":\"鼓楼区\",\"address\":\"1111\",\"custodian\":\"11111\",\"contactPersonPhone\":\"18200000000\",\"approachDate\":\"\",\"exitDate\":\"\",\"leaseModeNo\":null,\"leaseModeName\":\"1\",\"leasePrice\":\"\",\"settlementModeNo\":null,\"settlementModeName\":\"1\",\"contractNo\":\"\",\"remark\":\"\",\"equipmentAscriptionTable\":[{\"equipmentAscriptionId\":3,\"equipmentId\":3,\"party\":{\"partyId\":318,\"parType\":{\"parTypeId\":4,\"note\":\"企业\",\"name\":\"企业\",\"objectId\":4},\"region\":null,\"createTime\":\"2016-03-17 03:14:27\",\"updateTime\":\"2016-03-1703:14:27\",\"note\":\"中铁一局\",\"state\":0,\"budget\":null,\"code\":\"000000\",\"name\":\"中铁一局\",\"offAddr\":null,\"zip\":null,\"phone\":null,\"fax\":null,\"type\":null,\"contacts\":null,\"contactsMobile\":null,\"contactsEmail\":null,\"orgLevel\":2,\"parentCode\":\"000\",\"objectId\":318},\"objectId\":3}],\"equipmentId\":3,\"delFlag\":0,\"delDate\":null,\"quantity\":null,\"origin\":null,\"specialNo\":null,\"rentalUnit\":null,\"impExpFee\":null,\"subsidiaryName\":\"中铁一局一处\",\"projectName\":\"中铁一局1\",\"categoryId\":\"\"}";
				 Map objMap=BeanUtil.toObjectFromJson(jsonStrTemp, Map.class);
			     for(int i=0;i<RUN_COUNT;i++)
			     {
			    	 jsonStr=BeanUtil.toJsonString(objMap);
				      testPut(url,jsonStr);
			     }
			     printRunInfo(url,startTime);
			}
			
			/**
			 * 测试方法，添加设备（外部供应商）
			 * @throws Throwable
			 */
			@Test
			public void junitTestAddEquForProviderByQian() throws Throwable
			{
				 Long startTime=new Date().getTime();
				 
				 ObjectMapper mapper = new ObjectMapper();
				 OutputDataSearchBean testTableSearchBean = new OutputDataSearchBean();
				 String jsonStr = mapper.writeValueAsString(testTableSearchBean);
				
				 
				 String url="/BG/Equipment";
				 		 
				 String jsonStrTemp="{\"releaseState\":\"1\",\"rentType_\":\"1\",\"pubState\":\"1\",\"equipmentCategoryTable\":{\"0\":{\"categoryTable\":{}}},\"leaseModeName\":\"\",\"settlementModeName\":\"\",\"equNo\":\"test\",\"brandNo\":1,\"brandNoCopy\":1,\"brandName\":\"安迈\",\"manufacturer\":\"北京松源华兴生物技术有限公司\",\"manufacturerId\":13,\"busState\":\"\",\"equAtOrgName\":\"\",\"leasePrice\":\"\",\"contractNo\":\"\",\"remark\":\"\",\"equipmentSourceNo\":\"1\",\"equState\":\"1\",\"contactPersonPhone\":\"18700000000\",\"onProvince\":\"北京\",\"onCity\":\"北京市\",\"onDistrict\":\"朝阳区\",\"categoryId\":857,\"copyId\":857,\"equNameId\":290,\"partyId\":\"329\"}";
				 Map objMap=BeanUtil.toObjectFromJson(jsonStrTemp, Map.class);
			     for(int i=0;i<RUN_COUNT;i++)
			     {
			    	 objMap.put("code","code"+new Date().getTime());
			    	 objMap.put("name","name"+new Date().getTime());
			    	 jsonStr=BeanUtil.toJsonString(objMap);
				      testPut(url,jsonStr);
			     }
			     printRunInfo(url,startTime);
			}
			
			
			/**
			 * 测试方法，添加设备（外部供应商）
			 * @throws Throwable
			 */
			@Test
			public void junitTestAddContactInfoForProviderByQian() throws Throwable
			{
				 Long startTime=new Date().getTime();
				 
				 ObjectMapper mapper = new ObjectMapper();
				 OutputDataSearchBean testTableSearchBean = new OutputDataSearchBean();
				 String jsonStr = mapper.writeValueAsString(testTableSearchBean);
				 
				 String url="/BG/Party/ContactInfo";
				 		 
				 String jsonStrTemp="{\"tel\":\"18200000000\",\"qq\":null,\"name\":\"111\",\"partyName\":\"test\",\"onProvince\":\"北京\",\"onCity\":\"北京市\",\"onDistrict\":\"东城区\",\"defConFlag\":0,\"partyId\":\"329\"}";
				 Map objMap=BeanUtil.toObjectFromJson(jsonStrTemp, Map.class);
			     for(int i=0;i<RUN_COUNT;i++)
			     {
			    	 objMap.put("partyName","name"+new Date().getTime());
			    	 jsonStr=BeanUtil.toJsonString(objMap);
				      testPut(url,jsonStr);
			     }
			     printRunInfo(url,startTime);
			}
			
			
			
			
			/**
			 * 测试方法，添加求租信息
			 * @throws Throwable
			 */
			@Test
			public void junitTestAddDemandRentByQian() throws Throwable
			{
				 Long startTime=new Date().getTime();
				 
				 ObjectMapper mapper = new ObjectMapper();
				 OutputDataSearchBean testTableSearchBean = new OutputDataSearchBean();
				 String jsonStr = mapper.writeValueAsString(testTableSearchBean);
				
				 String url="/BG/DemandRent";
				 		 
				 String jsonStrTemp="{\"infoTitle\":\"发电船\",\"price\":\"11\",\"tenancy\":\"1\",\"quantity\":\"11\",\"enterpriseName\":\"test123\",\"onProvince\":\"北京\",\"onCity\":\"北京市\",\"onDistrict\":\"东城区\",\"contactPerson\":\"test321\",\"contactPhone\":\"18799999999\",\"inputCode\":\"067p\",\"detailedDescription\":\"<p>test<br/></p>\",\"equName\":\"发电船\",\"infoRadio\":4,\"priceType\":1,\"tenancyType\":1}";
				 
				 Map objMap=BeanUtil.toObjectFromJson(jsonStrTemp, Map.class);
			     for(int i=0;i<RUN_COUNT;i++)
			     {
			    	 jsonStr=BeanUtil.toJsonString(objMap);
				      testPut(url,jsonStr);
			     }
			     printRunInfo(url,startTime);
			}
			
			/**
			 * 测试方法，修改求租信息
			 * @throws Throwable
			 */
			@Test
			public void junitTestUpdDemandRentByQian() throws Throwable
			{
				 Long startTime=new Date().getTime();
				 
				 ObjectMapper mapper = new ObjectMapper();
				 OutputDataSearchBean testTableSearchBean = new OutputDataSearchBean();
				 String jsonStr = mapper.writeValueAsString(testTableSearchBean);
				
				 String url="/BG/DemandRent/30926";
				 		 
				 String jsonStrTemp="{\"dataId\":30926,\"process\":{\"processId\":30926,\"bizType\":3,\"bizName\":\"求租信息发布\",\"district\":null,\"originOrg\":null,\"operator\":null,\"defaultProcFlag\":false,\"objectId\":30926},\"dataState\":{\"dataState\":1,\"note\":\"待审核\",\"objectId\":1},\"updateTime\":\"2016-03-31 16:50:39\",\"dataType\":3,\"managerId\":3,\"originOrg\":null,\"district\":null,\"lastOper\":null,\"viewCount\":null,\"operateFlag\":0,\"orgCode\":null,\"equName\":\"发电船\",\"brandName\":null,\"modelName\":null,\"standardName\":null,\"onProvince\":\"北京\",\"onCity\":\"北京市\",\"onDistrict\":\"东城区\",\"useProvince\":null,\"useCity\":null,\"useDistrict\":null,\"address\":null,\"price\":\"11\",\"priceType\":1,\"tenancy\":1,\"tenancyType\":1,\"second\":null,\"expectedDeposit\":null,\"electronicMail\":null,\"fixedTelephone\":null,\"expectedAmount\":null,\"infoTitle\":\"发电船\",\"quantity\":11,\"detailedDescription\":\"<p>test<br/></p>\",\"equipmentPic\":null,\"releaseDate\":\"2016-03-31 15:40:05\",\"enterpriseName\":\"test123\",\"contactPerson\":\"test321\",\"contactPhone\":\"18755555555\",\"qqNo\":null,\"contactAddress\":null,\"faceCity\":null,\"atCity\":null,\"atCityDesc\":null,\"objectId\":30926,\"inputCode\":\"383l\",\"infoRadio\":4}";
				 
				 Map objMap=BeanUtil.toObjectFromJson(jsonStrTemp, Map.class);
			     for(int i=0;i<RUN_COUNT;i++)
			     {
			    	 jsonStr=BeanUtil.toJsonString(objMap);
				      testPost(url,jsonStr);
			     }
			     printRunInfo(url,startTime);
			}
			
			
			
			
			/**
			 * 测试方法，添加求购信息
			 * @throws Throwable
			 */
			@Test
			public void junitTestAddDemandSaleByQian() throws Throwable
			{
				 Long startTime=new Date().getTime();
				 
				 ObjectMapper mapper = new ObjectMapper();
				 OutputDataSearchBean testTableSearchBean = new OutputDataSearchBean();
				 String jsonStr = mapper.writeValueAsString(testTableSearchBean);
				
				 String url="/BG/DemandSale";
				 		 
				 String jsonStrTemp="{\"detailedDescription\":\"<p>test<br/></p>\",\"infoTitle\":\"发电船\",\"price\":\"111\",\"quantity\":\"11\",\"enterpriseName\":\"testee\",\"onProvince\":\"天津\",\"onCity\":\"天津市\",\"onDistrict\":\"和平区\",\"contactPerson\":\"test\",\"contactPhone\":\"18700000000\",\"inputCode\":\"mef5\",\"equName\":\"发电船\",\"infoRadio\":4}";
				 
				 Map objMap=BeanUtil.toObjectFromJson(jsonStrTemp, Map.class);
			     for(int i=0;i<RUN_COUNT;i++)
			     {
			    	 jsonStr=BeanUtil.toJsonString(objMap);
				      testPut(url,jsonStr);
			     }
			     printRunInfo(url,startTime);
			}
			
			
			/**
			 * 测试方法，修改求购信息
			 * @throws Throwable
			 */
			@Test
			public void junitTestUpdDemandSaleByQian() throws Throwable
			{
				 Long startTime=new Date().getTime();
				 
				 ObjectMapper mapper = new ObjectMapper();
				 OutputDataSearchBean testTableSearchBean = new OutputDataSearchBean();
				 String jsonStr = mapper.writeValueAsString(testTableSearchBean);
				
				 String url="/BG/DemandSale/60881";
				 		 
				 String jsonStrTemp="{\"dataId\":60881,\"process\":{\"processId\":60892,\"bizType\":4,\"bizName\":\"求购信息发布\",\"district\":null,\"originOrg\":null,\"operator\":null,\"defaultProcFlag\":false,\"objectId\":60892},\"dataState\":{\"dataState\":1,\"note\":\"待审核\",\"objectId\":1},\"updateTime\":\"2016-03-31 17:44:52\",\"dataType\":4,\"managerId\":3,\"originOrg\":null,\"district\":null,\"lastOper\":null,\"viewCount\":null,\"operateFlag\":0,\"orgCode\":null,\"equName\":\"发电船\",\"brandName\":null,\"modelName\":null,\"standardName\":null,\"onProvince\":\"北京\",\"onCity\":\"北京市\",\"onDistrict\":\"东城区\",\"address\":null,\"price\":\"111\",\"second\":null,\"expectedDeposit\":null,\"electronicMail\":null,\"fixedTelephone\":null,\"expectedAmount\":null,\"infoTitle\":\"发电船\",\"priceType\":null,\"quantity\":11,\"detailedDescription\":\"<p>test<br/></p>\",\"equipmentPic\":null,\"releaseDate\":\"2016-03-30 11:15:02\",\"enterpriseName\":\"testee\",\"contactPerson\":\"test\",\"contactPhone\":\"18755555555\",\"qqNo\":null,\"contactAddress\":null,\"faceCity\":null,\"atCity\":null,\"atCityDesc\":null,\"objectId\":60881,\"inputCode\":\"m38k\",\"infoRadio\":4}";
				 
				 Map objMap=BeanUtil.toObjectFromJson(jsonStrTemp, Map.class);
			     for(int i=0;i<RUN_COUNT;i++)
			     {
			    	 jsonStr=BeanUtil.toJsonString(objMap);
				      testPost(url,jsonStr);
			     }
			     printRunInfo(url,startTime);
			}
			
			
			
			
			
			/**
			 * 测试方法，添加出租信息
			 * @throws Throwable
			 */
			@Test
			public void junitTestAddRentByQian() throws Throwable
			{
				 Long startTime=new Date().getTime();
				 
				 ObjectMapper mapper = new ObjectMapper();
				 OutputDataSearchBean testTableSearchBean = new OutputDataSearchBean();
				 String jsonStr = mapper.writeValueAsString(testTableSearchBean);
				
				 String url="/BG/Rent";
				 		 
				 String jsonStrTemp="{\"contactPerson\":\"中铁1\",\"contactPhone\":\"18300000000\",\"qqNo\":\"18300000000\",\"equipmentPic\":\"f23f1299-da71-46c4-b50e-adbad4ebdfeb.jpg\",\"equipmentId\":11,\"infoTitle\":\"【安迈】发电船\",\"contactAddress\":null,\"price\":\"11\",\"shortestLease\":\"1\",\"inputCode\":\"7o1n\",\"detailedDescription\":\"<p>test<br/></p>\",\"priceType\":\"1\",\"enterpriseName\":\"中铁一局\",\"infoRadio\":1,\"equNo\":\"se\",\"power\":null,\"technicalStatus\":\"三类\",\"manufacturer\":\"北京松源华兴生物技术有限公司\",\"productionDate\":null,\"equName\":\"发电船\",\"brandName\":\"安迈\",\"modelName\":null,\"standardName\":null,\"onProvince\":\"北京\",\"onCity\":\"北京市\",\"onDistrict\":\"朝阳区\"}";
				 
				 Map objMap=BeanUtil.toObjectFromJson(jsonStrTemp, Map.class);
			     for(int i=0;i<RUN_COUNT;i++)
			     {
			    	 jsonStr=BeanUtil.toJsonString(objMap);
				      testPut(url,jsonStr);
			     }
			     printRunInfo(url,startTime);
			}
			
			
			/**
			 * 测试方法，修改出租信息
			 * @throws Throwable
			 */
			@Test
			public void junitTestUpdRentByQian() throws Throwable
			{
				 Long startTime=new Date().getTime();
				 
				 ObjectMapper mapper = new ObjectMapper();
				 OutputDataSearchBean testTableSearchBean = new OutputDataSearchBean();
				 String jsonStr = mapper.writeValueAsString(testTableSearchBean);
				
				 String url="/BG/Rent/122475";
				 		 
				 String jsonStrTemp="{\"dataId\":122475,\"process\":{\"processId\":122485,\"bizType\":1,\"bizName\":\"出租信息发布\",\"district\":null,\"originOrg\":null,\"operator\":null,\"defaultProcFlag\":false,\"objectId\":122485},\"dataState\":{\"dataState\":1,\"note\":\"待审核\",\"objectId\":1},\"updateTime\":\"2016-03-30 15:48:07\",\"dataType\":1,\"managerId\":3,\"originOrg\":318,\"district\":null,\"lastOper\":null,\"viewCount\":null,\"operateFlag\":0,\"orgCode\":\"000000\",\"equNo\":\"se\",\"power\":null,\"technicalStatus\":\"三类\",\"manufacturer\":\"北京松源华兴生物技术有限公司\",\"productionDate\":null,\"equName\":\"发电船\",\"brandName\":\"安迈\",\"modelName\":null,\"standardName\":null,\"onProvince\":\"北京\",\"onCity\":\"北京市\",\"onDistrict\":\"朝阳区\",\"shortestLease\":1,\"enterpriseName\":\"中铁一局\",\"electronicMail\":null,\"fixedTelephone\":null,\"infoTitle\":\"【安迈】发电船\",\"equipmentTable\":{\"bureauId\":318,\"subsidiaryId\":322,\"projectId\":3705,\"equNo\":\"se\",\"asset\":null,\"equipmentCategoryTable\":[{\"equipmentCategoryId\":20,\"equipmentId\":11,\"categoryTable\":{\"categoryId\":857,\"equCategory\":{\"equCategoryId\":44,\"equipmentCategoryNo\":\"102\",\"equipmentCategoryName\":\"动力机械\",\"objectId\":44},\"equName\":{\"equNameId\":290,\"equipmentNo\":\"10202\",\"equipmentName\":\"发电船\",\"second\":null,\"searchCount\":2,\"objectId\":290},\"typeNo\":\"100\",\"relationType\":2}}],\"brandNo\":1,\"brandName\":\"安迈\",\"manufacturerId\":13,\"manufacturer\":\"北京松源华兴生物技术有限公司\",\"productionDate\":null,\"facortyNo\":null,\"modelsId\":null,\"models\":null,\"specificationsId\":null,\"specifications\":null,\"powerId\":null,\"power\":null,\"equAtOrgId\":null,\"equAtOrgName\":\"\",\"equipmentCost\":null,\"purchaseDate\":null,\"technicalStatus\":3,\"licenseNo\":null,\"powerType\":null,\"equipmentSourceNo\":1,\"equipmentSourceName\":null,\"equState\":1,\"rentFlag\":0,\"saleFlag\":0,\"busState\":null,\"pubState\":1,\"atCity\":null,\"onProvince\":\"北京\",\"onCity\":\"北京市\",\"onDistrict\":\"朝阳区\",\"address\":null,\"custodian\":null,\"contactPersonPhone\":\"18799999999\",\"approachDate\":null,\"exitDate\":null,\"leaseModeNo\":null,\"leaseModeName\":\"\",\"leasePrice\":null,\"settlementModeNo\":null,\"settlementModeName\":\"\",\"contractNo\":\"\",\"remark\":\"\",\"equipmentAscriptionTable\":[{\"equipmentAscriptionId\":11,\"equipmentId\":11,\"party\":{\"partyId\":318,\"parType\":{\"parTypeId\":4,\"note\":\"企业\",\"name\":\"企业\",\"objectId\":4},\"region\":null,\"createTime\":\"2016-03-17 03:14:27\",\"updateTime\":\"2016-03-17 03:14:27\",\"note\":\"中铁一局\",\"state\":0,\"budget\":null,\"code\":\"000000\",\"name\":\"中铁一局\",\"offAddr\":null,\"zip\":null,\"phone\":null,\"fax\":null,\"type\":null,\"contacts\":null,\"contactsMobile\":null,\"contactsEmail\":null,\"orgLevel\":2,\"parentCode\":\"000\",\"objectId\":318},\"objectId\":11}],\"equipmentId\":11,\"delFlag\":0,\"delDate\":null,\"quantity\":null,\"origin\":null,\"specialNo\":null,\"rentalUnit\":null,\"impExpFee\":null},\"price\":\"11\",\"priceType\":\"1\",\"detailedDescription\":\"<p>test<br/></p>\",\"equipmentPic\":\"f23f1299-da71-46c4-b50e-adbad4ebdfeb.jpg\",\"releaseDate\":\"2016-03-30 15:48:07\",\"contactPerson\":\"中铁1\",\"contactPhone\":\"18300000000\",\"qqNo\":\"18355555555\",\"contactAddress\":null,\"atCity\":null,\"atCityDesc\":null,\"objectId\":122475,\"equipmentId\":11,\"inputCode\":\"111l\",\"infoRadio\":1}";
				 
				 Map objMap=BeanUtil.toObjectFromJson(jsonStrTemp, Map.class);
			     for(int i=0;i<RUN_COUNT;i++)
			     {
			    	 jsonStr=BeanUtil.toJsonString(objMap);
				      testPost(url,jsonStr);
			     }
			     printRunInfo(url,startTime);
			}
			
			
			/**
			 * 测试方法，我已发布的信息，刷新
			 * @throws Throwable
			 */
			@Test
			public void junitTestUpdBusPublishInfoByQian() throws Throwable
			{
				 Long startTime=new Date().getTime();
				 
				 ObjectMapper mapper = new ObjectMapper();
				 OutputDataSearchBean testTableSearchBean = new OutputDataSearchBean();
				 String jsonStr = mapper.writeValueAsString(testTableSearchBean);
				
				 String url="/BG/BusPublishInfo?id=120884";
				 		 
			     for(int i=0;i<RUN_COUNT;i++)
			     {
				      testPost(url,jsonStr);
			     }
			     printRunInfo(url,startTime);
			}
			
			
			/**
			 * 测试方法，添加出售信息
			 * @throws Throwable
			 */
			@Test
			public void junitTestAddSaleByQian() throws Throwable
			{
				 Long startTime=new Date().getTime();
				 
				 ObjectMapper mapper = new ObjectMapper();
				 OutputDataSearchBean testTableSearchBean = new OutputDataSearchBean();
				 String jsonStr = mapper.writeValueAsString(testTableSearchBean);
				
				 String url="/BG/Sale";
				 		 
				 String jsonStrTemp="{\"contactPerson\":\"中铁1\",\"contactPhone\":\"18300000000\",\"qqNo\":\"18300000000\",\"equipmentId\":17,\"infoTitle\":\"【安迈】发电船\",\"contactAddress\":null,\"price\":\"111\",\"equipmentPic\":\"e13ee066-5ba4-41cb-8917-127f1e8cafdf.jpg\",\"onProvince\":\"上海\",\"onCity\":\"上海市\",\"onDistrict\":\"徐汇区\",\"inputCode\":\"39k1\",\"detailedDescription\":\"<p>test<br/></p>\",\"enterpriseName\":\"中铁一局\",\"infoRadio\":2,\"equNo\":\"se\",\"power\":null,\"technicalStatus\":\"三类\",\"manufacturer\":\"北京松源华兴生物技术有限公司\",\"productionDate\":null,\"equName\":\"发电船\",\"brandName\":\"安迈\",\"modelName\":null,\"standardName\":null}";
				 
				 Map objMap=BeanUtil.toObjectFromJson(jsonStrTemp, Map.class);
			     for(int i=0;i<RUN_COUNT;i++)
			     {
			    	 jsonStr=BeanUtil.toJsonString(objMap);
				      testPut(url,jsonStr);
			     }
			     printRunInfo(url,startTime);
			}
			
			
			/**
			 * 测试方法，修改出售信息
			 * @throws Throwable
			 */
			@Test
			public void junitTestUpdSaleByQian() throws Throwable
			{
				 Long startTime=new Date().getTime();
				 
				 ObjectMapper mapper = new ObjectMapper();
				 OutputDataSearchBean testTableSearchBean = new OutputDataSearchBean();
				 String jsonStr = mapper.writeValueAsString(testTableSearchBean);
				
				 String url="/BG/Sale/120888";
				 		 
				 String jsonStrTemp="{\"dataId\":120888,\"process\":{\"processId\":120898,\"bizType\":2,\"bizName\":\"出售信息发布\",\"district\":null,\"originOrg\":null,\"operator\":null,\"defaultProcFlag\":false,\"objectId\":120898},\"dataState\":{\"dataState\":1,\"note\":\"待审核\",\"objectId\":1},\"updateTime\":\"2016-03-31 16:40:50\",\"dataType\":2,\"managerId\":3,\"originOrg\":318,\"district\":null,\"lastOper\":null,\"viewCount\":null,\"operateFlag\":0,\"orgCode\":\"000000\",\"equNo\":\"se\",\"power\":null,\"technicalStatus\":\"三类\",\"manufacturer\":\"北京松源华兴生物技术有限公司\",\"productionDate\":null,\"equName\":\"发电船\",\"brandName\":\"安迈\",\"modelName\":null,\"standardName\":null,\"onProvince\":\"上海\",\"onCity\":\"上海市\",\"onDistrict\":\"徐汇区\",\"enterpriseName\":\"中铁一局\",\"priceType\":null,\"shortestLease\":null,\"electronicMail\":null,\"fixedTelephone\":null,\"infoTitle\":\"【安迈】发电船\",\"equipmentTable\":{\"bureauId\":318,\"subsidiaryId\":322,\"projectId\":3705,\"equNo\":\"se\",\"asset\":null,\"equipmentCategoryTable\":[{\"equipmentCategoryId\":21,\"equipmentId\":17,\"categoryTable\":{\"categoryId\":857,\"equCategory\":{\"equCategoryId\":44,\"equipmentCategoryNo\":\"102\",\"equipmentCategoryName\":\"动力机械\",\"objectId\":44},\"equName\":{\"equNameId\":290,\"equipmentNo\":\"10202\",\"equipmentName\":\"发电船\",\"second\":null,\"searchCount\":2,\"objectId\":290},\"typeNo\":\"100\",\"relationType\":2}}],\"brandNo\":1,\"brandName\":\"安迈\",\"manufacturerId\":13,\"manufacturer\":\"北京松源华兴生物技术有限公司\",\"productionDate\":null,\"facortyNo\":null,\"modelsId\":null,\"models\":null,\"specificationsId\":null,\"specifications\":null,\"powerId\":null,\"power\":null,\"equAtOrgId\":null,\"equAtOrgName\":\"\",\"equipmentCost\":null,\"purchaseDate\":null,\"technicalStatus\":3,\"licenseNo\":null,\"powerType\":null,\"equipmentSourceNo\":1,\"equipmentSourceName\":null,\"equState\":1,\"rentFlag\":null,\"saleFlag\":null,\"busState\":null,\"pubState\":3,\"atCity\":null,\"onProvince\":\"北京\",\"onCity\":\"北京市\",\"onDistrict\":\"朝阳区\",\"address\":null,\"custodian\":null,\"contactPersonPhone\":\"18799999999\",\"approachDate\":null,\"exitDate\":null,\"leaseModeNo\":null,\"leaseModeName\":\"\",\"leasePrice\":null,\"settlementModeNo\":null,\"settlementModeName\":\"\",\"contractNo\":\"\",\"remark\":\"\",\"equipmentAscriptionTable\":[{\"equipmentAscriptionId\":12,\"equipmentId\":17,\"party\":{\"partyId\":318,\"parType\":{\"parTypeId\":4,\"note\":\"企业\",\"name\":\"企业\",\"objectId\":4},\"region\":null,\"createTime\":\"2016-03-17 03:14:27\",\"updateTime\":\"2016-03-17 03:14:27\",\"note\":\"中铁一局\",\"state\":0,\"budget\":null,\"code\":\"000000\",\"name\":\"中铁一局\",\"offAddr\":null,\"zip\":null,\"phone\":null,\"fax\":null,\"type\":null,\"contacts\":null,\"contactsMobile\":null,\"contactsEmail\":null,\"orgLevel\":2,\"parentCode\":\"000\",\"objectId\":318},\"objectId\":12}],\"equipmentId\":17,\"delFlag\":0,\"delDate\":null,\"quantity\":null,\"origin\":null,\"specialNo\":null,\"rentalUnit\":null,\"impExpFee\":null},\"price\":\"111\",\"detailedDescription\":\"<p>test<br/></p>\",\"equipmentPic\":\"e13ee066-5ba4-41cb-8917-127f1e8cafdf.jpg\",\"releaseDate\":\"2016-03-3115:43:38\",\"contactPerson\":\"中铁1\",\"contactPhone\":\"18300000000\",\"qqNo\":\"18300000000\",\"contactAddress\":null,\"atCity\":null,\"atCityDesc\":null,\"objectId\":120888,\"equipmentId\":17,\"inputCode\":\"lnfp\",\"infoRadio\":2}";
				 Map objMap=BeanUtil.toObjectFromJson(jsonStrTemp, Map.class);
			     for(int i=0;i<RUN_COUNT;i++)
			     {
			    	 jsonStr=BeanUtil.toJsonString(objMap);
				      testPost(url,jsonStr);
			     }
			     printRunInfo(url,startTime);
			}
			
			
			
			/**
			 * 测试方法，批量审批，审批通过的方法
			 * @throws Throwable
			 */
			@Test
			public void junitTestAuditsByQian() throws Throwable
			{
				 Long startTime=new Date().getTime();
				 
				 ObjectMapper mapper = new ObjectMapper();
				 OutputDataSearchBean testTableSearchBean = new OutputDataSearchBean();
				 String jsonStr = mapper.writeValueAsString(testTableSearchBean);
				
				 String url="/AUDIT/BusAuditInfo?Action=Audits";
				 		 
				 String jsonStrTemp="{\"dataIds\":[120694,120695,120696,120697,120698,120699,120700,120701,120702,120703,120704,120705,120706,120707,120708,120709,120710,120711,120712,120713]}";
				 
				 Map objMap=BeanUtil.toObjectFromJson(jsonStrTemp, Map.class);
			     for(int i=0;i<RUN_COUNT;i++)
			     {
			    	 jsonStr=BeanUtil.toJsonString(objMap);
				      testPost(url,jsonStr);
			     }
			     printRunInfo(url,startTime);
			}
			
			/**
			 * 测试方法，折旧费登记保存
			 * @throws Throwable
			 */
			@Test
			public void junitTestAddDepreciationHistByQian() throws Throwable
			{
				 Long startTime=new Date().getTime();
				 
				 ObjectMapper mapper = new ObjectMapper();
				 OutputDataSearchBean testTableSearchBean = new OutputDataSearchBean();
				 String jsonStr = mapper.writeValueAsString(testTableSearchBean);
				
				 
				 String url="/BG/DepreciationHist?Action=AddOrUpd";
				 		 
				 String jsonStrTemp="{\"bdhbtList\":[{\"asset\":\"11111\",\"categoryId\":857,\"productionDate\":\"2016-03-17\",\"equId\":1,\"brandNo\":1,\"brandName\":\"安迈\",\"equNo\":\"ju001\",\"equNameId\":290,\"id\":2,\"equipmentName\":\"发电船\",\"partyId\":318,\"depreciation\":null,\"month\":\"2016-03\",\"equipmentId\":1,\"assetA\":\"11111\",\"equNoA\":\"ju001\",\"equipmentNameA\":\"发电船\",\"brandNameA\":\"安迈\"}"
					     +",{\"asset\":\"111\",\"categoryId\":857,\"productionDate\":\"2016-03-17\",\"equId\":2,\"brandNo\":1,\"brandName\":\"安迈\",\"equNo\":\"ju002\",\"equNameId\":290,\"id\":3,\"equipmentName\":\"发电船\",\"partyId\":318,\"depreciation\":null,\"month\":\"2016-03\",\"equipmentId\":2,\"assetA\":\"111\",\"equNoA\":\"ju002\",\"equipmentNameA\":\"发电船\",\"brandNameA\":\"安迈\"}"
					     +",{\"asset\":\"111111\",\"categoryId\":857,\"productionDate\":\"2016-03-17\",\"equId\":3,\"brandNo\":1,\"brandName\":\"安迈\",\"equNo\":\"111111\",\"equNameId\":290,\"id\":4,\"equipmentName\":\"发电船\",\"partyId\":318,\"depreciation\":null,\"month\":\"2016-03\",\"equipmentId\":3,\"assetA\":\"111111\",\"equNoA\":\"111111\",\"equipmentNameA\":\"发电船\",\"brandNameA\":\"安迈\"}"
					     +",{\"asset\":null,\"categoryId\":857,\"productionDate\":null,\"equId\":4,\"brandNo\":1,\"brandName\":\"安迈\",\"equNo\":\"ju006\",\"equNameId\":290,\"id\":5,\"equipmentName\":\"发电船\",\"partyId\":318,\"depreciation\":null,\"month\":\"2016-03\",\"equipmentId\":4,\"equNoA\":\"ju006\",\"equipmentNameA\":\"发电船\",\"brandNameA\":\"安迈\"}"
					+ ",{\"asset\":null,\"categoryId\":857,\"productionDate\":null,\"equId\":5,\"brandNo\":2,\"brandName\":\"安利\",\"equNo\":\"ju007\",\"equNameId\":290,\"id\":6,\"equipmentName\":\"发电船\",\"partyId\":318,\"depreciation\":null,\"month\":\"2016-03\",\"equipmentId\":5,\"equNoA\":\"ju007\",\"equipmentNameA\":\"发电船\",\"brandNameA\":\"安利\"}"
					+ ",{\"asset\":null,\"categoryId\":857,\"productionDate\":null,\"equId\":6,\"brandNo\":2,\"brandName\":\"安利\",\"equNo\":\"ju0999\",\"equNameId\":290,\"id\":7,\"equipmentName\":\"发电船\",\"partyId\":318,\"depreciation\":null,\"month\":\"2016-03\",\"equipmentId\":6,\"equNoA\":\"ju0999\",\"equipmentNameA\":\"发电船\",\"brandNameA\":\"安利\"}"
					+ ",{\"asset\":null,\"categoryId\":857,\"productionDate\":null,\"equId\":7,\"brandNo\":2,\"brandName\":\"安利\",\"equNo\":\"ju008\",\"equNameId\":290,\"id\":8,\"equipmentName\":\"发电船\",\"partyId\":318,\"depreciation\":null,\"month\":\"2016-03\",\"equipmentId\":7,\"equNoA\":\"ju008\",\"equipmentNameA\":\"发电船\",\"brandNameA\":\"安利\"}"
					+ ",{\"asset\":null,\"categoryId\":857,\"productionDate\":null,\"equId\":8,\"brandNo\":1,\"brandName\":\"安迈\",\"equNo\":\"ju12\",\"equNameId\":290,\"id\":9,\"equipmentName\":\"发电船\",\"partyId\":318,\"depreciation\":null,\"month\":\"2016-03\",\"equipmentId\":8,\"equNoA\":\"ju12\",\"equipmentNameA\":\"发电船\",\"brandNameA\":\"安迈\"}"
					+ ",{\"asset\":null,\"categoryId\":876,\"productionDate\":null,\"equId\":9,\"brandNo\":1,\"brandName\":\"安迈\",\"equNo\":\"ju13\",\"equNameId\":289,\"id\":10,\"equipmentName\":\"发电车\",\"partyId\":318,\"depreciation\":null,\"month\":\"2016-03\",\"equipmentId\":9,\"equNoA\":\"ju13\",\"equipmentNameA\":\"发电车\",\"brandNameA\":\"安迈\"}"
					+ ",{\"asset\":null,\"categoryId\":857,\"productionDate\":null,\"equId\":11,\"brandNo\":1,\"brandName\":\"安迈\",\"equNo\":\"se\",\"equNameId\":290,\"id\":11,\"equipmentName\":\"发电船\",\"partyId\":318,\"depreciation\":null,\"month\":\"2016-03\",\"equipmentId\":11,\"equNoA\":\"se\",\"equipmentNameA\":\"发电船\",\"brandNameA\":\"安迈\"}"
					+ ",{\"asset\":null,\"categoryId\":857,\"productionDate\":null,\"equId\":17,\"brandNo\":1,\"brandName\":\"安迈\",\"equNo\":\"se\",\"equNameId\":290,\"id\":12,\"equipmentName\":\"发电船\",\"partyId\":318,\"depreciation\":null,\"month\":\"2016-03\",\"equipmentId\":17,\"equNoA\":\"se\",\"equipmentNameA\":\"发电船\",\"brandNameA\":\"安迈\"}"
					+ ",{\"asset\":null,\"categoryId\":857,\"productionDate\":null,\"equId\":14,\"brandNo\":1,\"brandName\":\"安迈\",\"equNo\":\"se\",\"equNameId\":290,\"id\":13,\"equipmentName\":\"发电船\",\"partyId\":318,\"depreciation\":null,\"month\":\"2016-03\",\"equipmentId\":14,\"equNoA\":\"se\",\"equipmentNameA\":\"发电船\",\"brandNameA\":\"安迈\"}"
					+ ",{\"asset\":null,\"categoryId\":857,\"productionDate\":null,\"equId\":12,\"brandNo\":1,\"brandName\":\"安迈\",\"equNo\":\"se\",\"equNameId\":290,\"id\":14,\"equipmentName\":\"发电船\",\"partyId\":318,\"depreciation\":null,\"month\":\"2016-03\",\"equipmentId\":12,\"equNoA\":\"se\",\"equipmentNameA\":\"发电船\",\"brandNameA\":\"安迈\"}"
					+ ",{\"asset\":null,\"categoryId\":857,\"productionDate\":null,\"equId\":15,\"brandNo\":1,\"brandName\":\"安迈\",\"equNo\":\"se\",\"equNameId\":290,\"id\":15,\"equipmentName\":\"发电船\",\"partyId\":318,\"depreciation\":null,\"month\":\"2016-03\",\"equipmentId\":15,\"equNoA\":\"se\",\"equipmentNameA\":\"发电船\",\"brandNameA\":\"安迈\"}"
					+ ",{\"asset\":null,\"categoryId\":857,\"productionDate\":null,\"equId\":13,\"brandNo\":1,\"brandName\":\"安迈\",\"equNo\":\"se\",\"equNameId\":290,\"id\":16,\"equipmentName\":\"发电船\",\"partyId\":318,\"depreciation\":null,\"month\":\"2016-03\",\"equipmentId\":13,\"equNoA\":\"se\",\"equipmentNameA\":\"发电船\",\"brandNameA\":\"安迈\"}"
					+ ",{\"asset\":null,\"categoryId\":857,\"productionDate\":null,\"equId\":18,\"brandNo\":1,\"brandName\":\"安迈\",\"equNo\":\"se\",\"equNameId\":290,\"id\":17,\"equipmentName\":\"发电船\",\"partyId\":318,\"depreciation\":null,\"month\":\"2016-03\",\"equipmentId\":18,\"equNoA\":\"se\",\"equipmentNameA\":\"发电船\",\"brandNameA\":\"安迈\"}"
					+ ",{\"asset\":null,\"categoryId\":857,\"productionDate\":null,\"equId\":16,\"brandNo\":1,\"brandName\":\"安迈\",\"equNo\":\"se\",\"equNameId\":290,\"id\":18,\"equipmentName\":\"发电船\",\"partyId\":318,\"depreciation\":null,\"month\":\"2016-03\",\"equipmentId\":16,\"equNoA\":\"se\",\"equipmentNameA\":\"发电船\",\"brandNameA\":\"安迈\"}"
					+ ",{\"asset\":null,\"categoryId\":857,\"productionDate\":null,\"equId\":19,\"brandNo\":1,\"brandName\":\"安迈\",\"equNo\":\"se\",\"equNameId\":290,\"id\":19,\"equipmentName\":\"发电船\",\"partyId\":318,\"depreciation\":null,\"month\":\"2016-03\",\"equipmentId\":19,\"equNoA\":\"se\",\"equipmentNameA\":\"发电船\",\"brandNameA\":\"安迈\"}"
					+ ",{\"asset\":null,\"categoryId\":857,\"productionDate\":null,\"equId\":20,\"brandNo\":1,\"brandName\":\"安迈\",\"equNo\":\"se\",\"equNameId\":290,\"id\":20,\"equipmentName\":\"发电船\",\"partyId\":318,\"depreciation\":null,\"month\":\"2016-03\",\"equipmentId\":20,\"equNoA\":\"se\",\"equipmentNameA\":\"发电船\",\"brandNameA\":\"安迈\"}"
					+ ",{\"asset\":null,\"categoryId\":857,\"productionDate\":null,\"equId\":21,\"brandNo\":1,\"brandName\":\"安迈\",\"equNo\":\"se\",\"equNameId\":290,\"id\":21,\"equipmentName\":\"发电船\",\"partyId\":318,\"depreciation\":null,\"month\":\"2016-03\",\"equipmentId\":21,\"equNoA\":\"se\",\"equipmentNameA\":\"发电船\",\"brandNameA\":\"安迈\"}]"
					+ ",\"month_\":\"2016-03\"}";
				 Map objMap=BeanUtil.toObjectFromJson(jsonStrTemp, Map.class);
			     for(int i=0;i<RUN_COUNT;i++)
			     {
			    	 jsonStr=BeanUtil.toJsonString(objMap);
				      testPost(url,jsonStr);
			     }
			     printRunInfo(url,startTime);
			}
			
			/**
			 * 测试方法，发布结果登记
			 * @throws Throwable
			 */
			@Test
			public void junitTestAddBusPublishHistByQian() throws Throwable
			{
				 Long startTime=new Date().getTime();
				 
				 ObjectMapper mapper = new ObjectMapper();
				 OutputDataSearchBean testTableSearchBean = new OutputDataSearchBean();
				 String jsonStr = mapper.writeValueAsString(testTableSearchBean);
				
				 
				 String url="/BG/BusPublishHist";
				 		 
				 String jsonStrTemp="{\"id\":null,\"dataId\":61044,\"state\":2,\"busState\":\"1\",\"note\":null,\"depName\":\"test\"}";
				 Map objMap=BeanUtil.toObjectFromJson(jsonStrTemp, Map.class);
			     for(int i=0;i<RUN_COUNT;i++)
			     {
			    	 jsonStr=BeanUtil.toJsonString(objMap);
				      testPut(url,jsonStr);
			     }
			     printRunInfo(url,startTime);
			}	
			
			
			
			/**
			 * 测试方法，租赁费登记-设备拥有者
			 * @throws Throwable
			 */
			@Test
			public void junitTestAddRentHistOwnerByQian() throws Throwable
			{
				 Long startTime=new Date().getTime();
				 
				 ObjectMapper mapper = new ObjectMapper();
				 OutputDataSearchBean testTableSearchBean = new OutputDataSearchBean();
				 String jsonStr = mapper.writeValueAsString(testTableSearchBean);
				
				 
				 String url="/BG/RentHistOwner?Action=AddOrUpd";
				 		 
				 String jsonStrTemp="{\"month_\":\"2016-03\",\"equipmentId\":3,\"brhtList\":[{\"rentType\":\"1\",\"depName\":\"1\",\"startEndDate\":\"1\",\"rent\":\"1\",\"rentCount\":\"1\",\"amount\":\"1\",\"cost\":\"1\",\"deductCost\":\"1\",\"note\":\"Test\",\"equAtOrgName\":\"中铁一局\",\"equAtOrgId\":318,\"equAtOrgCode\":\"000000\"}]}";
				 Map objMap=BeanUtil.toObjectFromJson(jsonStrTemp, Map.class);
			     for(int i=0;i<RUN_COUNT;i++)
			     {
			    	 jsonStr=BeanUtil.toJsonString(objMap);
				      testPost(url,jsonStr);
			     }
			     printRunInfo(url,startTime);
			}
			
						
			
		}

	
	
	
    /**
     * 测试线程类
     * @author Qian
     */
	class TestRunnable implements Runnable
	{
			@Override
			public void run() 
			{
//				//添加企业
//				new JUnitCore().run(Request.method(PerformanceTest.class, "junitTestAddEntByQian"));
//				//修改企业
//				new JUnitCore().run(Request.method(PerformanceTest.class, "junitTestUpdEntByQian"));
//				//添加内部员工
//				new JUnitCore().run(Request.method(PerformanceTest.class, "junitTestAddPerByQian"));
//				//修改内部员工
//				new JUnitCore().run(Request.method(PerformanceTest.class, "junitTestUpdPerByQian"));
//				//添加外部供应商
//				new JUnitCore().run(Request.method(PerformanceTest.class, "junitTestAddProviderByQian"));
//				//修改外部供应商
//				new JUnitCore().run(Request.method(PerformanceTest.class, "junitTestUpdProviderByQian"));
//				//添加设备小类名称
//				new JUnitCore().run(Request.method(PerformanceTest.class, "junitTestAddEquNameByQian"));
//				//修改设备小类名称
//				new JUnitCore().run(Request.method(PerformanceTest.class, "junitTestUpdEquNameByQian"));
//				//添加设备大类名称
//				new JUnitCore().run(Request.method(PerformanceTest.class, "junitTestAddEquCategoryByQian"));
//				//修改设备大类名称
//				new JUnitCore().run(Request.method(PerformanceTest.class, "junitTestUpdEquCategoryByQian"));
//				//添加设备分类，大小类的人为组合
//				new JUnitCore().run(Request.method(PerformanceTest.class, "junitTestAddCategoryByQian"));
//				//修改设备分类，大小类的人为组合
//				new JUnitCore().run(Request.method(PerformanceTest.class, "junitTestUpdCategoryByQian"));				
//				//添加项目
//				new JUnitCore().run(Request.method(PerformanceTest.class, "junitTestAddProByQian"));
//				//修改项目
//				new JUnitCore().run(Request.method(PerformanceTest.class, "junitTestUpdProByQian"));
//				//添加设备
				new JUnitCore().run(Request.method(PerformanceTest.class, "junitTestAddEquByQian"));
//				//修改设备——使用情况完成
//				new JUnitCore().run(Request.method(PerformanceTest.class, "junitTestAddUseInfoByQian"));
//				//添加设备——外部供应商
//				new JUnitCore().run(Request.method(PerformanceTest.class, "junitTestAddEquForProviderByQian"));
//				//添加联系人
//				new JUnitCore().run(Request.method(PerformanceTest.class, "junitTestAddContactInfoForProviderByQian"));
//				//修改设备
//				new JUnitCore().run(Request.method(PerformanceTest.class, "junitTestUpdEquByQian"));
//				//添加求租信息
//				new JUnitCore().run(Request.method(PerformanceTest.class, "junitTestAddDemandRentByQian"));
//				//修改求租信息
//				new JUnitCore().run(Request.method(PerformanceTest.class, "junitTestUpdDemandRentByQian"));
//				//添加求购信息
//				new JUnitCore().run(Request.method(PerformanceTest.class, "junitTestAddDemandSaleByQian"));
//				//修改求购信息
//				new JUnitCore().run(Request.method(PerformanceTest.class, "junitTestUpdDemandSaleByQian"));
//				//添加出租信息
//				new JUnitCore().run(Request.method(PerformanceTest.class, "junitTestAddRentByQian"));
//				//修改出租信息
//				new JUnitCore().run(Request.method(PerformanceTest.class, "junitTestUpdRentByQian"));
//				//添加出售信息
//				new JUnitCore().run(Request.method(PerformanceTest.class, "junitTestAddSaleByQian"));
//				//修改出售信息
//				new JUnitCore().run(Request.method(PerformanceTest.class, "junitTestUpdSaleByQian"));
//				//批量审核，添加过求租、求购、出租、出售的信息后，都会出现在审核列表中，审核通过的才会出现在求租、求购、出租、出售的四个列表中
//				new JUnitCore().run(Request.method(PerformanceTest.class, "junitTestAuditsByQian"));
//				//折旧费登记，添加折旧费
//				new JUnitCore().run(Request.method(PerformanceTest.class, "junitTestAddDepreciationHistByQian"));
//				//发布结果登记
//				new JUnitCore().run(Request.method(PerformanceTest.class, "junitTestAddBusPublishHistByQian"));
//				//租赁费登记-设备拥有者
//				new JUnitCore().run(Request.method(PerformanceTest.class, "junitTestAddRentHistOwnerByQian"));
//				//我已发布的信息，刷新
//				new JUnitCore().run(Request.method(PerformanceTest.class, "junitTestUpdBusPublishInfoByQian"));
				
				
				
				
				
//				new JUnitCore().run(Request.method(PerformanceTest.class, "junitTest"));
//				new JUnitCore().run(Request.method(PerformanceTest.class, "junitTest1"));
//				new JUnitCore().run(Request.method(PerformanceTest.class, "junitTest2"));
//				new JUnitCore().run(Request.method(PerformanceTest.class, "junitTestQueryYin3"));
//				new JUnitCore().run(Request.method(PerformanceTest.class, "junitTestQueryYin4"));
//				new JUnitCore().run(Request.method(PerformanceTest.class, "junitTestQueryYin5"));
//				new JUnitCore().run(Request.method(PerformanceTest.class, "junitTestQueryYin6"));
//				new JUnitCore().run(Request.method(PerformanceTest.class, "junitTestQueryYin8"));
//				new JUnitCore().run(Request.method(PerformanceTest.class, "junitTestQueryYin9"));
//				new JUnitCore().run(Request.method(PerformanceTest.class, "junitTestQueryYin10"));
//				new JUnitCore().run(Request.method(PerformanceTest.class, "junitTestQueryYin12"));
//				new JUnitCore().run(Request.method(PerformanceTest.class, "junitTestQueryYin13"));
//				new JUnitCore().run(Request.method(PerformanceTest.class, "junitTestQueryYin14"));
//				new JUnitCore().run(Request.method(PerformanceTest.class, "junitTestQueryYin15"));
//				new JUnitCore().run(Request.method(PerformanceTest.class, "junitTestQueryYin16"));
//				new JUnitCore().run(Request.method(PerformanceTest.class, "junitTestQueryYin17"));
//				new JUnitCore().run(Request.method(PerformanceTest.class, "junitTestQueryYin18"));
//				new JUnitCore().run(Request.method(PerformanceTest.class, "junitTestQueryYin20"));
//				new JUnitCore().run(Request.method(PerformanceTest.class, "junitTestQueryYin21"));
//				new JUnitCore().run(Request.method(PerformanceTest.class, "junitTestQueryYin22"));
//				new JUnitCore().run(Request.method(PerformanceTest.class, "junitTestQueryYin23"));
//				new JUnitCore().run(Request.method(PerformanceTest.class, "junitTestQueryYin24"));
//				new JUnitCore().run(Request.method(PerformanceTest.class, "junitTestQueryYin26"));
//				new JUnitCore().run(Request.method(PerformanceTest.class, "junitTestQueryYin27"));
//				new JUnitCore().run(Request.method(PerformanceTest.class, "junitTestQueryYin28"));
//				new JUnitCore().run(Request.method(PerformanceTest.class, "junitTestQueryYin29"));
//				new JUnitCore().run(Request.method(PerformanceTest.class, "junitTestQueryYin30"));
//				new JUnitCore().run(Request.method(PerformanceTest.class, "junitTestQueryYin30"));
//				new JUnitCore().run(Request.method(PerformanceTest.class, "junitTestQueryYin32"));
//				new JUnitCore().run(Request.method(PerformanceTest.class, "junitTestQueryYin35"));
//				new JUnitCore().run(Request.method(PerformanceTest.class, "junitTestQueryYin36"));
//				new JUnitCore().run(Request.method(PerformanceTest.class, "junitTestQueryYin37"));
//				new JUnitCore().run(Request.method(PerformanceTest.class, "junitTestQueryYin38"));
//				new JUnitCore().run(Request.method(PerformanceTest.class, "junitTestQueryYin39"));
//				new JUnitCore().run(Request.method(PerformanceTest.class, "junitTestQueryYin40"));
//				new JUnitCore().run(Request.method(PerformanceTest.class, "junitTestQueryYin41"));
//				new JUnitCore().run(Request.method(PerformanceTest.class, "junitTestQueryYin42"));
//				new JUnitCore().run(Request.method(PerformanceTest.class, "junitTestQueryYin43"));
//				new JUnitCore().run(Request.method(PerformanceTest.class, "junitTestQueryYin44"));
//				new JUnitCore().run(Request.method(PerformanceTest.class, "junitTestQueryYin45"));
//				new JUnitCore().run(Request.method(PerformanceTest.class, "junitTestQueryYin46"));
//				new JUnitCore().run(Request.method(PerformanceTest.class, "junitTestQueryYin47"));
//				new JUnitCore().run(Request.method(PerformanceTest.class, "junitTestQueryYin48"));
//				new JUnitCore().run(Request.method(PerformanceTest.class, "junitTestQueryYin49"));
//				new JUnitCore().run(Request.method(PerformanceTest.class, "junitTestQueryYin50"));
//				new JUnitCore().run(Request.method(PerformanceTest.class, "junitTestQueryYin51"));
//				new JUnitCore().run(Request.method(PerformanceTest.class, "junitTestQueryYin52"));
//				new JUnitCore().run(Request.method(PerformanceTest.class, "junitTestQueryYin53"));
//				new JUnitCore().run(Request.method(PerformanceTest.class, "junitTestQueryYin54"));
//				new JUnitCore().run(Request.method(PerformanceTest.class, "junitTestQueryYin55"));
//				new JUnitCore().run(Request.method(PerformanceTest.class, "junitTestQueryYin56"));
//				new JUnitCore().run(Request.method(PerformanceTest.class, "junitTestQueryYin57"));
//				new JUnitCore().run(Request.method(PerformanceTest.class, "junitTestQueryYin59"));
//				new JUnitCore().run(Request.method(PerformanceTest.class, "junitTestQueryYin60"));
//				new JUnitCore().run(Request.method(PerformanceTest.class, "junitTestQueryYin61"));
				
				
				
//				new JUnitCore().run(Request.method(PerformanceTest.class, "junitTestQueryYin62"));
//				new JUnitCore().run(Request.method(PerformanceTest.class, "junitTestQueryYin63"));
//				new JUnitCore().run(Request.method(PerformanceTest.class, "junitTestQueryYin64"));
//				new JUnitCore().run(Request.method(PerformanceTest.class, "junitTestQueryYin65"));
//				new JUnitCore().run(Request.method(PerformanceTest.class, "junitTestQueryYin66"));
//				new JUnitCore().run(Request.method(PerformanceTest.class, "junitTestQueryYin67"));
//				new JUnitCore().run(Request.method(PerformanceTest.class, "junitTestQueryYin68"));
//				new JUnitCore().run(Request.method(PerformanceTest.class, "junitTestQueryYin69"));
//				new JUnitCore().run(Request.method(PerformanceTest.class, "junitTestQueryYin70"));
//				new JUnitCore().run(Request.method(PerformanceTest.class, "junitTestQueryYin71"));
//				new JUnitCore().run(Request.method(PerformanceTest.class, "junitTestQueryYin72"));
//				new JUnitCore().run(Request.method(PerformanceTest.class, "junitTestQueryYin73"));
//				new JUnitCore().run(Request.method(PerformanceTest.class, "junitTestQueryYin74"));
//				new JUnitCore().run(Request.method(PerformanceTest.class, "junitTestQueryYin75"));
//				new JUnitCore().run(Request.method(PerformanceTest.class, "junitTestQueryYin76"));
//				new JUnitCore().run(Request.method(PerformanceTest.class, "junitTestQueryYin77"));
//				new JUnitCore().run(Request.method(PerformanceTest.class, "junitTestQueryYin78"));
//				new JUnitCore().run(Request.method(PerformanceTest.class, "junitTestQueryYin80"));
//				new JUnitCore().run(Request.method(PerformanceTest.class, "junitTestQueryYin81"));
//				new JUnitCore().run(Request.method(PerformanceTest.class, "junitTestQueryYin82"));
//				new JUnitCore().run(Request.method(PerformanceTest.class, "junitTestQueryYin83"));
//				new JUnitCore().run(Request.method(PerformanceTest.class, "junitTestQueryYin84"));
			}
	}
