app.controller('infoPublishController', function ($scope,$route,$timeout,proSvc,rentSvc, SaleSvc,partyConTactSvc , equipment, PicSvc, regionSvc, entSvc, category,PicUrl) {
  			
	
				function qSucc(rec){
        			if(rec.content.length!=0){
        				$scope.allequiList=rec.content;
        				$scope.Info_List.equName = null;
        				/*$scope.paginationConf.totalItems=rec.totalElements;*/
        				
        			}else{

        				$.messager.popup("没有符合条件的记录");
        				$scope.allequiList=rec.content;
        				$scope.btnShow_ = false;
        				$scope.Info_List.equName = null;
        				/*$scope.paginationConf.totalItems=rec.totalElements;*/
        			}
        		
        		}
        		function qErr(rec){
        			
        		}
        		equipment.post({Action:"Provider"},{
        			pageNo:0,
        			pageSize:20,
        			partyId:$scope.userInfo.orgId,
                  	equState:1,
                    pubState:1,
                    equipmentSourceNo:1,
                    equName:$scope.Info_List.equName,
        			},qSucc,qErr);
		
        	$scope.Select = function(params,parm1){     //选中该条信息
	            $scope.InfoList=params;
	        };
	        
	        $scope.Detail = function(params){
	               
	        }
	       
	        $scope.Confirm = function(){         //确认按钮
	        	 
	        	  if($scope.InfoList==null){
	        		  $.messager.popup("请选择一条数据");
	        		  return;
	        	  }else{
	        		  $scope.$emit('InfopubList',{saveParm:$scope.InfoList});
		  			  window.location.href="/WebSite/Mobile/Index.jsp#/Infopub";
	        	  }
	  			  
	  		 
	     	};
        		
	   });