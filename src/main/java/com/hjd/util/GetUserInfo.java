package com.hjd.util;

import java.io.IOException;

import javax.xml.parsers.ParserConfigurationException;

import org.xml.sax.SAXException;

public class GetUserInfo {

	public static void main(String[] args) throws IOException, SAXException, ParserConfigurationException {

		SendToTransport transport = new SendToTransport();
		for(int i=0;i<1;i++){
			transport.send("getUserInfos~&~accj~!~~!~~!~1000000050~!~sdnpqQJLwcj7dJI0s7jMA6E1RtWKBYp7");
			
			/*transport.send("getUserInfos~&~dada~!~~!~~!~1000000050~!~sdnpqQJLwcj7dJI0s7jMA6E1RtWKBYp7");*/

//			transport.send("interfaceList~&~GetGSPUserInfo~!~{\"userCode\":\"zs001\"}~!~2~!~1000000050~!~sdnpqQJLwcj7dJI0s7jMA6E1RtWKBYp7");
			}
		}

	}
