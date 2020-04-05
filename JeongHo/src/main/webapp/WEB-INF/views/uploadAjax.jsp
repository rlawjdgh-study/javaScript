<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
	<style type="text/css">
		.uploadResult {
			width: 100%;
			background-color: gray;
		}

		.uploadResult ul {
			display: flex;
			flex-flow: row;
			justify-content: center;
			align-items: center;
		} 
		
		.uploadResult ul li {
			list-style: none;
			padding: 10px;
		}
		
		.uploadResult ul li img {
			width: 100px;
		}
		</style>
		
		<style>
		.bigPictureWrapper {
		  position: absolute;
		  display: none;
		  justify-content: center;
		  align-items: center;
		  top:0%;
		  width:100%;
		  height:100%;
		  background-color: gray; 
		  z-index: 100;
		}
		
		.bigPicture {
		  position: relative;
		  display:flex;
		  justify-content: center;
		  align-items: center;
		}
	</style>
</head>
<body>
	<h1>Upload with Ajax</h1>
	
	<div class="uploadDiv">
		<input type="file" name="uploadFile" multiple>
	</div>
	<button id="uploadBtn">Upload</button>
	
	<div class="uploadResult">
		<ul></ul>
	</div> 
	
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	<script type="text/javascript">
		
	
		function showImage(fileCallPath){
			alert(fileCallPath);
		}
		 
		$(document).ready(function() {
			
			var regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$");
			var maxSize = 5242880; // 5MB
			
			function checkExtension(fileName, fileSize) {
				
				if(fileSize >= maxSize) {
					alert("파일 사이즈 초과");
					return false;
				}
				if(regex.test(fileName)) {
					alert("해당 종류의 파일은 업로드할 수 없습니다.");
					return false;
				}
				
				return true;
			}
			
			var cloneObj = $(".uploadDiv").clone();
			   
			$("#uploadBtn").on("click", function() {
				var formData = new FormData();
				var inputFile = $("input[name='uploadFile']");
				var files = inputFile[0].files; 
				
				for(var i = 0; i < files.length; i++) {
					if(!checkExtension(files[i].name, files[i].size)) {
						return false;
					}
					
					formData.append("uploadFile", files[i]);
				}  
				 
				$.ajax({
					url : '/uploadAjaxAction',
					processData : false,
					contentType : false, 
					data : formData,
					type : 'POST',
					dataType : 'json',
					success : function(result) {
						
						showUploadedFile(result);
						$(".uploadDiv").html(cloneObj.html()); 
					}
				});
				
			});
			
			var uploadResult = $(".uploadResult ul");
			
			function showUploadedFile(uploadResultArr) {
				
				var str = "";
				$(uploadResultArr).each(function(i, obj) {
					
					if(!obj.image) {
						var fileCallPath = encodeURIComponent(obj.uploadPath + "/" + obj.uuid + "_" + obj.fileName);
						
						str += "<li>";
							str += "<a href='/download?fileName="+fileCallPath+"'>"; 
							str += "<img src='/resources/img/attach.png'>" + obj.fileName+"</a>";
						str += "</li>"; 
						
					} else {
						var fileCallPath =  encodeURIComponent( obj.uploadPath+ "/s_"+obj.uuid +"_"+obj.fileName);
						
						var originPath = obj.uploadPath+ "\\"+obj.uuid +"_"+obj.fileName;
						originPath = originPath.replace(new RegExp(/\\/g),"/");
						
						str += "<li>";
							str += "<a href=\"javascript:showImage(\'"+originPath+"\')\"><img src='display?fileName="+fileCallPath+"'></a>";
						str += "</li>";
					}  
				});
				 
				uploadResult.append(str); 
			}
			
		});
	</script>
</body>
</html>