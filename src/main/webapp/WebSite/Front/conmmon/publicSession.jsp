<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script type="text/javascript">
	/*
	*可供调用的Session
	*/
	var SYS_USER_INFO={};
	SYS_USER_INFO.orgId="${sessionScope.userInfo.orgId}";
	SYS_USER_INFO.code="${sessionScope.userInfo.code}";
	SYS_USER_INFO.orgName="${sessionScope.userInfo.orgName}";
	SYS_USER_INFO.orgParentCode="${sessionScope.userInfo.orgParentCode}";
	SYS_USER_INFO.loginUserId="${sessionScope.userInfo.loginUserId}";
	SYS_USER_INFO.orgLevel="${sessionScope.userInfo.orgLevel}";
	SYS_USER_INFO.partyId="${sessionScope.userInfo.perPartyId}";
	SYS_USER_INFO.proId="${sessionScope.userInfo.proId}";
	SYS_USER_INFO.proName="${sessionScope.userInfo.proName}";
	SYS_USER_INFO.orgParTypeId="${sessionScope.userInfo.orgParTypeId}";
</script>