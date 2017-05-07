package main.test;

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.Arrays;
import java.util.Date;

import org.junit.Test;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.MediaType;

import com.alibaba.fastjson.JSONObject;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.hjd.action.bean.EquipmentBean;
import com.hjd.action.bean.OutputDataSearchBean;
import com.hjd.action.bean.PartyPersonBean;
import com.hjd.action.bean.TestTableBean;
import com.hjd.action.bean.TestTableSearchBean;
import com.hjd.util.Util;


public class TestActionTest extends TestBase {
	/**
	 * 日志
	 */
	protected final Logger logger = LoggerFactory.getLogger(this.getClass()); 
	/**
	 * 添加记录
	 */
	@Test
	public void addTestTable() throws Throwable{

		TestTableBean testTableBean = new TestTableBean();
		testTableBean.setAmount(new BigDecimal("30000"));
		testTableBean.setName("测试");
		testTableBean.setLongTextTest("测试长文本测试长文本测试长文本测试长文本测试长文本测试长文本测试长文本测试长文本测试长文本测试长文本测试长文本测试长文本测试长文本测试长文本测试长文本测试长文本测试长文本测试长文本测试长文本测试长文本测试长文本测试长文本测试长文本测试长文本测试长文本测试长文本测试长文本测试长文本测试长文本测试长文本测试长文本测试长文本测试长文本测试长文本测试长文本测试长文本测试长文本测试长文本测试长文本");
		testTableBean.setTimestampTest(new Date());
		testTableBean.setDateTest(new Date());
		
		ObjectMapper mapper = new ObjectMapper();
		String jsonStr = mapper.writeValueAsString(testTableBean); 
		
		
		putTest("/TestTable",jsonStr);
	}
	/**
	 * 修改记录
	 */
	@Test
	public void updateTestTable() throws Throwable{

		TestTableBean testTableBean = new TestTableBean();
		testTableBean.setAmount(new BigDecimal("40000"));
		testTableBean.setName("测试");
		testTableBean.setTestId(1);
		testTableBean.setLongTextTest("测试长文本测试长文本测试长文本测试长文本测试长文本测试长文本测试长文本测试长文本测试长文本测试长文本测试长文本测试长文本测试长文本测试长文本测试长文本测试长文本测试长文本测试长文本测试长文本测试长文本测试长文本测试长文本测试长文本测试长文本测试长文本测试长文本测试长文本测试长文本测试长文本测试长文本测试长文本测试长文本测试长文本测试长文本测试长文本测试长文本测试长文本测试长文本测试长文本");
		testTableBean.setTimestampTest(new Date());
		testTableBean.setDateTest(new Date());
		
		ObjectMapper mapper = new ObjectMapper();
		String jsonStr = mapper.writeValueAsString(testTableBean); 
		postTest("/TestTable/1",jsonStr);
	}

	/**
	 * 删除记录
	 */
	@Test
	public void deleteTestTable()throws Throwable{
		deleteTest("/TestTable/1");
	}
	/**
	 * 根据id查询记录
	 */
	@Test
	public void getTestTable()throws Throwable{
		String result = mockMvc
				.perform(get("/TestTable/1").contentType(MediaType.APPLICATION_JSON))
				.andExpect(status().isOk()).andReturn()
				.getResponse().getContentAsString();
	 	printResult(result);
	}
	/**
	 * 根据条件查询记录
	 */
	@Test
	public void searchTestTable()throws Throwable{
		TestTableSearchBean testTableSearchBean = new TestTableSearchBean();
		testTableSearchBean.setName("测试");
		testTableSearchBean.setPageNo(0);
		testTableSearchBean.setPageSize(10);
		
		ObjectMapper mapper = new ObjectMapper();
		String jsonStr = mapper.writeValueAsString(testTableSearchBean); 
		
		postTest("/TestTable?Action=All",jsonStr);
	}
	
	/**
	 * 测试根据区域子节点查询区域名称
	 */
	@Test
	public void regionSearchTest()throws Throwable{
		TestTableSearchBean testTableSearchBean = new TestTableSearchBean();
		testTableSearchBean.setName("测试");
		testTableSearchBean.setPageNo(0);
		testTableSearchBean.setPageSize(10);
		
		ObjectMapper mapper = new ObjectMapper();
		String jsonStr = mapper.writeValueAsString(testTableSearchBean); 
		//0、1、2、11、011、10000000000均经过测试
		postTest("/Party/Region/11?Action=RegionName",jsonStr);
	}
	
	/**
	 * 测试热词搜索的查询
	 */
	@Test
	public void hotWordSearchTest()throws Throwable{
		TestTableSearchBean testTableSearchBean = new TestTableSearchBean();
		testTableSearchBean.setName("测试");
		testTableSearchBean.setPageNo(0);
		testTableSearchBean.setPageSize(10);
		
		ObjectMapper mapper = new ObjectMapper();
		String jsonStr = mapper.writeValueAsString(testTableSearchBean); 
		getTest("/Category?Action=HotEquName&hotWord=我的锅炉",jsonStr);
	}
	/**
	 * 测试热词搜索的查询
	 */
	@Test
	public void hotWordSearchTest_()throws Throwable{
		TestTableSearchBean testTableSearchBean = new TestTableSearchBean();
		testTableSearchBean.setName("测试");
		testTableSearchBean.setPageNo(0);
		testTableSearchBean.setPageSize(10);
		
		ObjectMapper mapper = new ObjectMapper();
		String jsonStr = mapper.writeValueAsString(testTableSearchBean); 
		getTest("/Category?Action=HotEquName",jsonStr);
	}
	/**
	 * 测试热词搜索的查询
	 */
	@Test
	public void recentSearchTest()throws Throwable{
		TestTableSearchBean testTableSearchBean = new TestTableSearchBean();
		testTableSearchBean.setName("测试");
		testTableSearchBean.setPageNo(0);
		testTableSearchBean.setPageSize(10);
		
		ObjectMapper mapper = new ObjectMapper();
		String jsonStr = mapper.writeValueAsString(testTableSearchBean); 
		getTest("/Category?Action=RecentSearch&hotWord=我的锅1炉",jsonStr);
	}
	
	
	/**
	 * 测试热词搜索的查询
	 */
	@Test
	public void loginTest()throws Throwable{
		TestTableSearchBean testTableSearchBean = new TestTableSearchBean();
		testTableSearchBean.setName("测试");
		testTableSearchBean.setPageNo(0);
		testTableSearchBean.setPageSize(10);
		
		ObjectMapper mapper = new ObjectMapper();
		String jsonStr = mapper.writeValueAsString(testTableSearchBean); 
		getTest("/Sys/User?Action=Login&userName=我是登录名194&password=hello&gusi=hello",jsonStr);
	}
	
	/**
	 * 测试热词搜索的查询
	 */
	@Test
	public void logoutTest()throws Throwable{
		TestTableSearchBean testTableSearchBean = new TestTableSearchBean();
		testTableSearchBean.setName("测试");
		testTableSearchBean.setPageNo(0);
		testTableSearchBean.setPageSize(10);
		
		ObjectMapper mapper = new ObjectMapper();
		String jsonStr = mapper.writeValueAsString(testTableSearchBean); 
		getTest("/Sys/User?Action=Logout&gusi=hello",jsonStr);
	}
	
	/**
	 * 测试用户编号是否存在
	 */
	@Test
	public void checkCodeExistTest()throws Throwable{
		TestTableSearchBean testTableSearchBean = new TestTableSearchBean();
		testTableSearchBean.setName("测试");
		testTableSearchBean.setPageNo(0);
		testTableSearchBean.setPageSize(10);
		
		ObjectMapper mapper = new ObjectMapper();
		String jsonStr = mapper.writeValueAsString(testTableSearchBean); 
		getTest("/Party/Per?code=01&gusi=hello",jsonStr);
	}
	
	/**
	 * 测试获取设备分类类别、名称的详情
	 */
	@Test
	public void queryCategoryTest()throws Throwable{
		TestTableSearchBean testTableSearchBean = new TestTableSearchBean();
		testTableSearchBean.setName("测试");
		testTableSearchBean.setPageNo(0);
		testTableSearchBean.setPageSize(10);
		
		ObjectMapper mapper = new ObjectMapper();
		String jsonStr = mapper.writeValueAsString(testTableSearchBean); 
		getTest("/Category/56?Action=EquNameId&gusi=hello",jsonStr);
	}
	
	/**
	 * 测试根据首字母获取对一个的信息
	 */
	@Test
	public void queryEquNameTest()throws Throwable{
		EquipmentBean testTableSearchBean = new EquipmentBean();
		String[] fpy={"B","C","D"};
		testTableSearchBean.setFpy(fpy);
		ObjectMapper mapper = new ObjectMapper();
		String jsonStr = mapper.writeValueAsString(testTableSearchBean); 
		getTest("/Category?Action=EquBrandFpy",jsonStr);
	}
	
	
	/**
	 * 测试发布信息的条数
	 */
	@Test
	public void queryCountTest()throws Throwable{
		EquipmentBean testTableSearchBean = new EquipmentBean();
		String[] fpy={"B","C","D"};
		testTableSearchBean.setFpy(fpy);
		ObjectMapper mapper = new ObjectMapper();
		String jsonStr = mapper.writeValueAsString(testTableSearchBean); 
		getTest("/Issue?Action=ITCount&infoType=1&infoTitle=我们",jsonStr);
	}
	
	/**
	 * 测试获取品牌、生产厂家、规格、型号
	 */
	@Test
	public void queryEquXXXTest()throws Throwable{
		EquipmentBean testTableSearchBean = new EquipmentBean();
		String[] fpy={"B","C","D"};
		testTableSearchBean.setFpy(fpy);
		ObjectMapper mapper = new ObjectMapper();
		String jsonStr = mapper.writeValueAsString(testTableSearchBean); 
		/*getTest("/Issue?Action=queryEquBrand",jsonStr);*/
		/*getTest("/Issue?Action=queryEquManufacturer",jsonStr);*/
		/*getTest("/Issue?Action=queryEquStandard",jsonStr);*/
		/*getTest("/Issue?Action=queryEquModel",jsonStr);*/
/*		getTest("/Issue?Action=EquNameFpy",jsonStr);*/
		
		getTest("/Issue?Action=ResourceCount",jsonStr);
	
	}
	
	/**
	 * 测试为网站提供数据的接口
	 */
	@Test
	public void outputDataTest()throws Throwable{
		OutputDataSearchBean testTableSearchBean = new OutputDataSearchBean();
		ObjectMapper mapper = new ObjectMapper();
		String jsonStr = mapper.writeValueAsString(testTableSearchBean);
		//获取设备大类名称及设备租赁系统的首页地址
		/*postTest("/EquSys/OutputData?Action=EquCategoryName",jsonStr);*/
		
		//获取发布审核通过的信息集合，安发布日期降序排序
		/*postTest("/EquSys/OutputData?Action=EquPublishTitle",jsonStr);*/
		
		//测试折旧费登记
		/*postTest("/BG/DepreciationHist",jsonStr);*/
		
		//测试原生的折旧费登记的查询功能
		/*postTest("/BG/DepreciationHist",jsonStr);*/
		
		//测试原生的折旧费登记的查询功能
		/*postTest("/BG/RentHistOwner",jsonStr);*/
		//
		/*postTest("/Issue?Action=Rent",jsonStr);*/
		
		//测试获取外部供应商的信息
//		postTest("/Issue?Action=GetProviders",jsonStr);
		
	}
	
	/**
	 * 根据设备小类的来查询设备参数的集合
	 */
	@Test
	public void busEquParameterTest()throws Throwable{
		OutputDataSearchBean testTableSearchBean = new OutputDataSearchBean();
		ObjectMapper mapper = new ObjectMapper();
		String jsonStr = mapper.writeValueAsString(testTableSearchBean);
		getTest("/BG/BusEquParameter?Action=GET_BUS_EQU_NAME_PARAMETER",jsonStr);
		
	}
	
	/**
	 * 测试原生的SQL语句
	 * @throws Throwable
	 */
	@Test
	public void equTest()throws Throwable{
		OutputDataSearchBean testTableSearchBean = new OutputDataSearchBean();
		ObjectMapper mapper = new ObjectMapper();
		String jsonStr = mapper.writeValueAsString(testTableSearchBean);
		getTest("/Equipment?Action=All",jsonStr);
	}
	
	
	/**
	 * @throws Throwable
	 */
	@Test
	public void equCNTest()throws Throwable{
		OutputDataSearchBean testTableSearchBean = new OutputDataSearchBean();
		ObjectMapper mapper = new ObjectMapper();
		String jsonStr = mapper.writeValueAsString(testTableSearchBean);
		/*getTest("/Issue?Action=ByCategoryId&equCategoryId=17",jsonStr);*/
		
		getTest("/Issue?Action=HomePage",jsonStr);
	}
	
	
//	/**
//	 * 测试表明Long类型的数值不能直接使用!=来比较值不相等
//	 * @throws Throwable
//	 */
//	@Test
//	public void longEqual() throws Throwable 
//	{
//       Long l=309L;
//       Long l_=309L;
//       logger.debug("长整型的数据进行比较的方式： "+(l!=l_));
//       if(1==1 & 0!=0)
//       {
//    	   logger.debug("int 类型的数据可以直接使用==或者!=比较");//print
//       }
//       if(1==1 && l!=l_)
//       {
//    	   logger.debug("测试&&");//print
//       }
//       
//      logger.debug(l==l_);//false
//      logger.debug(l.compareTo(l_));//0
//      logger.debug(l.equals(l_));//true
//	}
//	
//	
//	@Test
//	public void longEqual2() throws Throwable 
//	{
//		Long a = 1L;
//		Long a_ = 1L;
//		if(a!=a_){
//			System.err.println("111");
//		}
//		else if(a.equals(1L)){
//			System.err.println("222");
//		}
//		else{
//			System.err.println("333");
//		}
//
//	}
	
	
	
	@Test
	public void dateTest()throws Throwable{
	    SimpleDateFormat simpleDateFormat=new SimpleDateFormat("yyyy-MM");
	    
logger.debug(simpleDateFormat.format(new Date()));
	    
	    
/*	    Date month=simpleDateFormat.parse("2015-12-01");
	    System.out.print(month.toLocaleString());*/
	    
	    
	    
	    
	    
	    
/*	    Date month_=simpleDateFormat.parse("2015-12");//不是一个正确的日期格式
	    System.out.print(month_.toLocaleString());
	    
	    Date month__=simpleDateFormat.parse("2015");//不是一个正确的日期格式
	    System.out.print(month__.toLocaleString());*/
	}
	
	/**
	 * 测试字符串数组转换成字符串的各种情况
	 * @throws Throwable
	 */
	@Test
	public void arrayTest()throws Throwable{
/*		String[] equNames={"土拉几","推土机","吊车"};*///ok
		
		/*String[] equNames={"土拉几"};*///ok
		
/*		String[] equNames={""};*///ok
		
		String[] equNames=null;
		String as=Util.arrayToString(equNames);
logger.debug("test array is : "+as.toString());
	}
	
	/**
	 * 测试JSON的使用
	 * @throws Throwable
	 */
	@Test
	public void jsonTest()throws Throwable{
		String js="{'user_name':'Tom'}";
		JSONObject jo = JSONObject.parseObject(js);
logger.debug(jo.getString("user_name"));
	}
	
	/**
	 * 测试数组的排序
	 * @throws Throwable
	 */
	@Test
	public void javaArrayTest()throws Throwable{
		 int[] a={5,4,2,4,9,1};   
         Arrays.sort(a);  //进行排序   
         for(int i: a)
         {   
            System.err.print(i);   
         }  
	}
	
	/**
	 * 测试外部通讯交易
	 */
	@Test
	public void externalCommActionTest()throws Throwable{

//		String result = mockMvc
//				.perform(get("/BG/Party/CheckSysUser/zs001").contentType(MediaType.APPLICATION_JSON))
//				.andExpect(status().isOk()).andReturn()
//				.getResponse().getContentAsString();

		String result = mockMvc
				.perform(get("/BG/Party/GetVmappInfoByUserCode/zs001").contentType(MediaType.APPLICATION_JSON))
				.andExpect(status().isOk()).andReturn()
				.getResponse().getContentAsString();

	 	printResult(result);
		}

	/**
	 * 测试移动端客户注册
	 */
	@Test
	public void mobileUserRegTest()throws Throwable{

		PartyPersonBean person = new PartyPersonBean();

		person.setLoginId("mobile");
		person.setMobile("12345678901");
		person.setPwd("mobile");
		person.setConfPwd("mobile");
		
		ObjectMapper mapper = new ObjectMapper();
		String jsonStr = mapper.writeValueAsString(person); 

		putTest("/BG/Party/MobileUserReg",jsonStr);
		
		}

	
	
	/**
	 * 压力测试：
	 * 1：采用单元测试加多线程的方式，使用多线程模拟多个用户，然后使用循环调用来模拟并发操作
	 * 2：先定义post/get/put/delete四种测试方法，不要打印，不需要返回值
	 * 3：测试时记录每个方法的起始时间、结束时间、总时间、平均时间，并且查看跑应用时的系统性能参数
	 * 4：最好能够生成对应的测试报告，详细的记录每一次测试的情况
	 */
	@Test
	public void junitThreadTest()
	{
        for(int i=0;i<10;i++)
        {   
        	Runnable r=new TestRunnable();
    		Thread t =  new Thread(r);
    		t.start();
/*    		try {
    			      Thread.sleep(1000); //主线程睡眠1秒钟
    			   } catch (InterruptedException e) {
    			             e.printStackTrace();
    			   }*/
        	
/*        	Runnable check = new Runnable() {
    			public void run() {
    				 Long startTime=new Date().getTime();
    			     for(int i=0;i<1000;i++)
    			     {
    			  		OutputDataSearchBean testTableSearchBean = new OutputDataSearchBean();
    					ObjectMapper mapper = new ObjectMapper();
    					String jsonStr = null;
    					
    					try {
    						jsonStr = mapper.writeValueAsString(testTableSearchBean);
    					} catch (JsonProcessingException e1) {
    						e1.printStackTrace();
    					}
    					
    					//测试获取外部供应商的信息
    					try {
    					   testPost("/Issue?Action=GetProviders",jsonStr);
    					} catch (Throwable e) {
    						e.printStackTrace();
    					}
    					
    			     }
    			     Long endTime=new Date().getTime();
    			     System.err.println("开始时间："+startTime+"   结束时间："+endTime+"   总时间："+(endTime-startTime)+"   平均时间："+(endTime-startTime)/1000+"---"+this.toString());
    				}
    			};

    		Thread checkThread =  new Thread(check);
    		checkThread.start();*/
    		
        }
	}

/**
 * 线程的一种实现方法，实现Runnable接口复写run方法
 * @author Qian
 *
 */
class TestRunnable implements Runnable{
	public void run() 
	{
	     Long startTime=new Date().getTime();
	     
	     for(int i=0;i<1000;i++)
	     {
	  		OutputDataSearchBean testTableSearchBean = new OutputDataSearchBean();
			ObjectMapper mapper = new ObjectMapper();
			String jsonStr = null;
			
			try {
				jsonStr = mapper.writeValueAsString(testTableSearchBean);
			} catch (JsonProcessingException e1) {
				e1.printStackTrace();
			}
			
			//测试获取外部供应商的信息
			try {
			   testPost("/Issue?Action=GetProviders",jsonStr);
			} catch (Throwable e) {
				e.printStackTrace();
			}
	     }
	     
	     Long endTime=new Date().getTime();
	     System.err.println("开始时间："+startTime+"   结束时间："+endTime+"   总时间："+(endTime-startTime)+"   平均时间："+(endTime-startTime)/1000+"---"+this.toString());
	     
	}
 }



	
//	private void checkPayeeInfo(final Context context, final List list) {
//
//		Runnable check = new Runnable() {
//			public void run() {
//				
//				}
//			};
//
//		Thread checkThread =  new Thread(check);
//		checkThread.start();
//		}
	
	}
