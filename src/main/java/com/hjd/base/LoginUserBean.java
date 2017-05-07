package com.hjd.base;

import java.util.Date;

public class LoginUserBean {

	private String loginName;
	private String passWord;
	private String sessionId;
	private Date currentTime;
	private Date heartbeat;
	
	
	public Date getHeartbeat() {
		return heartbeat;
	}
	public void setHeartbeat(Date heartbeat) {
		this.heartbeat = heartbeat;
	}
	public String getSessionId() {
		return sessionId;
	}
	public void setSessionId(String sessionId) {
		this.sessionId = sessionId;
	}
	public String getLoginName() {
		return loginName;
	}
	public void setLoginName(String loginName) {
		this.loginName = loginName;
	}
	public String getPassWord() {
		return passWord;
	}
	public void setPassWord(String passWord) {
		this.passWord = passWord;
	}
	public Date getCurrentTime() {
		return currentTime;
	}
	public void setCurrentTime(Date currentTime) {
		this.currentTime = currentTime;
	}
	
}
