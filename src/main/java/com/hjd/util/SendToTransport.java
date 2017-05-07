package com.hjd.util;

import org.apache.cxf.endpoint.Client;
import org.apache.cxf.jaxws.endpoint.dynamic.JaxWsDynamicClientFactory;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.hjd.base.IFException;

public class SendToTransport {

	private Logger logger = LoggerFactory.getLogger(getClass());

	private static final String url = "http://122.113.40.170:9080/luban-ids/webservice/userinfo?wsdl";

	private static JaxWsDynamicClientFactory wsDCFactory = JaxWsDynamicClientFactory.newInstance();
	private static Client client = wsDCFactory.createClient(url);

	public String send(String sendData) {

		this.logger.info("向{}发送交易数据,交易名称：{}", new Object[]{url, sendData});

		String[] data = sendData.split("~&~");
		if(data==null || data.length<=0){
			this.logger.error("http通讯错误，无法获取请求信息");

			throw new IFException("http通讯错误，无法获取请求信息");
			}

		String returnData = "";

		try{
			Object[] receive = client.invoke(data[0],doFormat(data[1]));
			if(receive==null || receive.length<=0){
				this.logger.error("http通讯错误，解析报文错误");

				throw new IFException("http通讯错误，解析报文错误");
				}

			returnData = (String)receive[0];

			this.logger.info("收到返回数据：{}", new Object[]{returnData});

			return returnData;
			}
		catch(Exception e){
			this.logger.error("http通讯错误，通讯异常");

			throw new IFException("http通讯错误，通讯异常");
			}
		}

	private Object[] doFormat(String params) {

		String[] data = params.split("~!~");
		if(data==null || data.length<=0)
			return new Object[0];

		return data;
		}

	}
