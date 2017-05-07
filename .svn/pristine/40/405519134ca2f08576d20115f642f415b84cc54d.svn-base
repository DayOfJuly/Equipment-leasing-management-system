package com.hjd.base;

public class IFException extends RuntimeException {

	private static final long serialVersionUID = 1709713481982096508L;

	protected String errCode;
	protected String errMsg;

	protected final String SYS_ERROR_CODE = "500";

	private void setErrInfo(String errCode, String errMsg){

		this.errCode = errCode;
		this.errMsg = errMsg;
		}

	public IFException() {

		super();
		setErrInfo(SYS_ERROR_CODE,"");
		}

	public IFException(String errCode, String errMsg) {

		super();
		setErrInfo(errCode,errMsg);
		}

	public IFException(String message, Throwable cause, boolean enableSuppression, boolean writableStackTrace) {

		super(message, cause, enableSuppression, writableStackTrace);
		setErrInfo(SYS_ERROR_CODE,message);
		}

	public IFException(String message, Throwable cause) {

		super(message, cause);
		setErrInfo(SYS_ERROR_CODE,message);
		}

	public IFException(String message) {

		super(message);
		setErrInfo(SYS_ERROR_CODE,message);
		}

	public IFException(Throwable cause) {

		super(cause);
		setErrInfo(SYS_ERROR_CODE,"");
		}

	public String getErrCode() {

		return errCode;
		}

	public void setErrCode(String errCode) {

		this.errCode = errCode;
		}

	public String getErrMsg() {

		return errMsg;
		}

	public void setErrMsg(String errMsg) {

		this.errMsg = errMsg;
		}

	}
