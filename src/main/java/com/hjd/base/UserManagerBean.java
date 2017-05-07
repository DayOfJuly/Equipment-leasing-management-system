package com.hjd.base;

import java.util.HashMap;
import java.util.Map;

import com.hjd.domain.SysLoginUser;

/**
 * 用户登陆信息维护entity
 * 
 * @author Administrator
 *
 */
public class UserManagerBean {

	private Map<String, SysLoginUser> userMap;

	public Map<String, SysLoginUser> getUserMap() {
		if (userMap == null) {
			userMap = new HashMap<String, SysLoginUser>();
		}
		return userMap;
	}

	public void setUserMap(Map<String, SysLoginUser> userMap) {
		this.userMap = userMap;
	}
	
	

}
