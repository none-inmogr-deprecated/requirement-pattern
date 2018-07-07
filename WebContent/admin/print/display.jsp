<%@page import="org.inmogr.java.web.software.development.requirements.global.HTML"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="com.google.gson.JsonObject" %>
<!--  -->
<jsp:useBean id="auth" class="org.inmogr.java.web.software.development.requirements.beans.AuthenticationBean" scope="session"></jsp:useBean>
<!--  -->
<!DOCTYPE html>
<html>
<head>
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>Requirement Pattern</title>
	<%=HTML.JQUERY%>
	<%=HTML.POPPER%>
	<%=HTML.BOOT_JS%>
	<%=HTML.BOOT_CSS%>
</head>
<body>
    <div class="container">
        <div class="row my-3">
            <div class="col text-center">
                <div class="dropdown">
                    <button class="btn btn-secondary dropdown-toggle" type="button" id="dropdownMenuButton" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                        Add
                    </button>
                    <div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
                    	<a class="dropdown-item" href=<%=("\""+HTML.ADMIN_DIR+"/add"+"/SPLDomain.jsp"+"\"")%>>SPL Domain</a>
						<a class="dropdown-item" href=<%=("\""+HTML.ADMIN_DIR+"/add"+"/RequirementPattern.jsp"+"\"")%>>Requirement Pattern</a>
						<a class="dropdown-item" href=<%=("\""+HTML.ADMIN_DIR+"/add"+"/Solution.jsp"+"\"")%>>Solution</a>
						<a class="dropdown-item" href=<%=("\""+HTML.ADMIN_DIR+"/add"+"/Requirement.jsp"+"\"")%>>Requirement</a>
						<a class="dropdown-item" href=<%=("\""+HTML.ADMIN_DIR+"/add"+"/CommonReq.jsp"+"\"")%>>Common Req</a>
						<a class="dropdown-item" href=<%=("\""+HTML.ADMIN_DIR+"/add"+"/VariableReq.jsp"+"\"")%>>Variable Req</a>
                    </div>
                </div>
            </div>
            <div class="col text-center">
            	<a class="btn btn-secondary" href=<%=("\""+HTML.ADMIN_DIR+"/list"+"\"")%>>
            		List
            	</a>
            </div>
            <div class="col text-center">
                <form action="signout">
                    <input type="submit" value="Sign Out" class="btn btn-danger">
                </form>
            </div>
        </div>
    </div>
    <%
	if (!auth.isAuthenticated()) {
		response.sendRedirect(HTML.ADMIN_DIR+"/sign");
	}
	else {
		%>
		<jsp:useBean id="dataList" class="org.inmogr.java.web.software.development.requirements.beans.ListItemsBean" scope="session"></jsp:useBean>
		<jsp:useBean id="print" class="org.inmogr.java.web.software.development.requirements.beans.PrintBean" scope="session"></jsp:useBean>
		<jsp:setProperty property="indexOfRP" name="print"/>
		<%
		print.setData(dataList);
		if (!print.hasData()) {
			response.sendRedirect(HTML.ADMIN_DIR+"/list");
		}
		else {
			if (print.indexOfRP < 0) {
				print.setIndexOfRP(0);
			}
			else if (print.indexOfRP > (print.listOfRequirementPattern.size()-1)) {
				print.setIndexOfRP(print.listOfRequirementPattern.size()-1);
			}
			%>
			<div class="container py-3">
	            <div class="row mt-5 mb-3">
	                <div class="col-9">
	                    <h2>
	                    	<%=print.objectOfSPLDomain.getSPLDomainName()%>
	                    </h2>
	                </div>
	                <div class="col-3">
	                    <div class="container-fluid text-center">
	                    	<strong class="font-italic">
	                        	Current RP:
	                        </strong>
	                        <%=print.indexOfRP%>
	                    </div>
	                    <div class="container-fluid">
	                        <div class="row">
		                        <form action="display.jsp" method="get" class="col-6 text-right">
		                            <input type="hidden" name="indexOfRP" value=<%=("\""+(print.indexOfRP-1)+"\"")%>>
		                            <input type="submit" value="Pervious" class="btn btn-secondary">
		                        </form>
		                        <form action="display.jsp" method="get" class="col-6 text-left">
		                            <input type="hidden" name="indexOfRP" value=<%=("\""+(print.indexOfRP+1)+"\"")%>>
		                            <input type="submit" value="Next" class="btn btn-primary">
		                        </form>
	                        </div>
	                    </div>
	                </div>
	            </div>
				<table class="table table-bordered">
					<thead class="thead-dark text-center">
						<tr>
							<th scope="col" style="width: 30%;" colspan="2">Section</th>
							<th scope="col" style="width: 70%;">Description</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<th scope="row" colspan="2">*Pattern Name</th>
							<td><%=print.listOfRequirementPattern.get(print.indexOfRP).getPatternName()%></td>
						</tr>
						<tr>
							<th scope="row" colspan="2">Also Known As</th>
							<td><%=print.listOfRequirementPattern.get(print.indexOfRP).getAKA()%></td>
						</tr>
						<tr>
							<th scope="row" colspan="2">Authors</th>
							<td><%=print.listOfRequirementPattern.get(print.indexOfRP).getAuthor().getName()%></td>
						</tr>
						<tr>
		                    <th scope="row" rowspan="5">*Context / Applicability</th>
							<th scope="row">*RE Activity</th>
							<td><%=print.listOfRequirementPattern.get(print.indexOfRP).getContext().getReqAct().name()%></td>
						</tr>
						<tr>
		                    <!-- ONE COLUMN USED ALREADY -->
							<th scope="row">*Pattern Type</th>
							<td><%=print.listOfRequirementPattern.get(print.indexOfRP).getContext().getPatternType().name()%></td>
						</tr>
						<tr>
		                    <!-- ONE COLUMN USED ALREADY -->
							<th scope="row">Business Domain</th>
							<td><%=print.listOfRequirementPattern.get(print.indexOfRP).getContext().getBussinessDomain()%></td>
						</tr>
						<tr>
		                    <!-- ONE COLUMN USED ALREADY -->
							<th scope="row">Organization Environmental Factors</th>
							<td><%=print.listOfRequirementPattern.get(print.indexOfRP).getContext().getOrganizationFactor()%></td>
						</tr>
						<tr>
		                    <!-- ONE COLUMN USED ALREADY -->
							<th scope="row">Stakeholders</th>
							<td><%=print.listOfRequirementPattern.get(print.indexOfRP).getContext().getStakeholder().getRole()%></td>
						</tr>
						<tr>
							<th scope="row" colspan="2">*Problem AKA Intent and Objective</th>
							<td><%=print.listOfRequirementPattern.get(print.indexOfRP).getProblem()%></td>
						</tr>
						<tr>
							<th scope="row" colspan="2">*Force</th>
							<td><%=print.listOfRequirementPattern.get(print.indexOfRP).getForce()%></td>
						</tr>
						<tr>
							<th scope="row" colspan="2">*Solution</th>
							<td>See "Solution Section" below</td>
						</tr>
						<tr>
							<th scope="row" colspan="2">*Application and Example</th>
							<td>
								<span class="font-italic">
									Application:
								</span>
								<span>
									<%=print.listOfRequirementPattern.get(print.indexOfRP).getApplication()%>
								</span>
								<br>
								<span class="font-italic">
									Example:
								</span>
								<span>
									<%=print.listOfRequirementPattern.get(print.indexOfRP).getExample()%>
								</span>
							</td>
						</tr>
						<tr>
							<th scope="row" colspan="2">*Known Uses</th>
							<td><%=print.listOfRequirementPattern.get(print.indexOfRP).getKnownUses()%></td>
						</tr>
						<tr>
		                    <th scope="row" rowspan="2">Cataloging:</th>
							<th scope="row">Classification</th>
							<td><%=print.listOfRequirementPattern.get(print.indexOfRP).getClassification().getClassType()%></td>
						</tr>
						<tr>
		                    <!-- ONE COLUMN USED ALREADY -->
							<th scope="row">Related Pattern</th>
							<td><%=print.listOfRequirementPattern.get(print.indexOfRP).getRelatedPatternID()%></td>
						</tr>
						<tr>
		                    <th scope="row" rowspan="3">Custom Section</th>
							<th scope="row">Consideration for Design</th>
							<td>
								another fill in the gaps by Imam to be fixed later
								<%=print.listOfRequirementPattern.get(print.indexOfRP).getConsideration().getConConstraint()%>
							</td>
						</tr>
						<tr>
		                    <!-- ONE COLUMN USED ALREADY -->
							<th scope="row">Consideration for Development</th>
							<td>
								another fill in the gaps by Imam to be fixed later
								<%=print.listOfRequirementPattern.get(print.indexOfRP).getConsideration().getConConstraint()%>
							</td>
						</tr>
						<tr>
		                    <!-- ONE COLUMN USED ALREADY -->
							<th scope="row">Consideration for Testing</th>
							<td>
								another fill in the gaps by Imam to be fixed later
								<%=print.listOfRequirementPattern.get(print.indexOfRP).getConsideration().getConConstraint()%>
							</td>
						</tr>
					</tbody>
				</table>
			</div>
		    <!---->
		    <!---->
		    <!---->
		    <!---->
		    <!---->
			<div class="container py-3">
		        <div class="container-fluid my-4">
		            <h2>
		                Solution Section
		            </h2>
		        </div>
				<table class="table table-bordered">
					<thead class="thead-dark text-center">
						<tr>
							<th scope="col" style="width: 20%;">Section</th>
							<th scope="col" style="width: 80%;" colspan="3">Description</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<th scope="row">Pattern Name</th>
							<td colspan="3"><%=print.listOfSolution.get(print.indexOfRP).getSolutionName()%></td>
						</tr>
						<tr>
							<th scope="row">Goal</th>
							<td colspan="3"><%=print.listOfSolution.get(print.indexOfRP).getGoal()%></td>
						</tr>
						<tr>
							<th scope="row">Description</th>
							<td colspan="3"><%=print.listOfSolution.get(print.indexOfRP).getDescription()%></td>
						</tr>
						<%
						for(int index1 = 0 ; index1 < print.listOfRequirement.get(print.indexOfRP).size() ; index1++) {
							%>
							<tr class="bg-primary text-white">
			                    <th scope="row">Requirement ID</th>
								<td colspan="3"><%=print.listOfRequirement.get(print.indexOfRP).get(index1).getReqID()%></td>
							</tr>
							<tr>
			                    <th scope="row">Requirement Name</th>
								<td colspan="3"><%=print.listOfRequirement.get(print.indexOfRP).get(index1).getReqName()%></td>
							</tr>
							<%
							for(int index2 = 0 ; index2 < print.listOfCommonReq.get(print.indexOfRP).get(index1).size() ; index2++) {
								%>
								<tr class="bg-success text-white">
				                    <th scope="row">Common Requirement ID</th>
									<td colspan="3"><%=print.listOfCommonReq.get(print.indexOfRP).get(index1).get(index2).getCommonReqID()%></td>
								</tr>
								<tr>
				                    <th scope="row" rowspan="4">Common Requirement Form</th>
									<td style="width: 20%;">Description</td>
									<td colspan="3"><%=print.listOfCommonReq.get(print.indexOfRP).get(index1).get(index2).getCommonDescription()%></td>
								</tr>
								<tr>
				                    <!-- ONE COLUMN USED ALREADY -->
									<td style="width: 20%;">Constraints</td>
									<td colspan="3"><%=print.listOfCommonReq.get(print.indexOfRP).get(index1).get(index2).getCommonConstraint()%></td>
				                </tr>
								<tr>
				                    <!-- ONE COLUMN USED ALREADY -->
									<td style="width: 20%;">Fixed Part</td>
									<td style="width: 20%;">Form Text</td>
									<td><%=print.listOfCommonReq.get(print.indexOfRP).get(index1).get(index2).getFixedPart()%></td>
								</tr>
								<tr>
				                    <!-- ONE COLUMN USED ALREADY -->
									<td style="width: 20%;">Extended Part</td>
									<td style="width: 20%;">Form Text</td>
									<td><%=print.listOfCommonReq.get(print.indexOfRP).get(index1).get(index2).getExtendedPart()%></td>
								</tr>
								<%
							}
							for(int index3 = 0 ; index3 < print.listOfVariableReq.get(print.indexOfRP).get(index1).size() ; index3++) {
								%>
								<tr class="bg-success text-white">
				                    <th scope="row">Variable Requirement ID</th>
									<td colspan="3"><%=print.listOfVariableReq.get(print.indexOfRP).get(index1).get(index3).getVariableReqID()%></td>
								</tr>
								<tr>
				                    <th scope="row" rowspan="4">Variable Requirement Form</th>
									<td style="width: 20%;">Description</td>
									<td colspan="2"><%=print.listOfVariableReq.get(print.indexOfRP).get(index1).get(index3).getVarDescription()%></td>
								</tr>
								<tr>
				                    <!-- ONE COLUMN USED ALREADY -->
									<td style="width: 20%;">Constraints</td>
									<td colspan="2"><%=print.listOfVariableReq.get(print.indexOfRP).get(index1).get(index3).getVarConstraint()%></td>
								</tr>
								<tr>
				                    <!-- ONE COLUMN USED ALREADY -->
									<td style="width: 20%;">Fixed Part</td>
									<td style="width: 20%;">Form Text</td>
									<td><%=print.listOfVariableReq.get(print.indexOfRP).get(index1).get(index3).getFixedPart()%></td>
								</tr>
								<tr>
				                    <!-- ONE COLUMN USED ALREADY -->
									<td style="width: 20%;">Variable Req</td>
									<td style="width: 20%;">Variation Points / Variants</td>
									<td><%=print.listOfVariableReq.get(print.indexOfRP).get(index1).get(index3).getVariationPoint()%></td>
								</tr>
								<tr>
				                    <th scope="row" rowspan="3">Variable Model Form</th>
									<td style="width: 20%;">Description / VP Names</td>
									<td colspan="2"><%=print.listOfVariableReq.get(print.indexOfRP).get(index1).get(index3).getVPNameAsString()%></td>
								</tr>
								<tr>
				                    <!-- ONE COLUMN USED ALREADY -->
									<td style="width: 20%;">Constraints / V Names</td>
									<td colspan="2"><%=print.listOfVariableReq.get(print.indexOfRP).get(index1).get(index3).getVNameAsString()%></td>
								</tr>
								<tr>
				                    <!-- ONE COLUMN USED ALREADY -->
									<td style="width: 20%;">Model (s)</td>
									<td colspan="2"><%=print.listOfVariableReq.get(print.indexOfRP).get(index1).get(index3).getVarPart().getModel()%></td>
								</tr>
								<%
							}
						}
						%>
					</tbody>
				</table>
			</div>
			<link rel="stylesheet" href="css.css">
			<script type="text/javascript" src="js.js"></script>
			<div class="container mt-5 py-3" id="select-file-area">
		        <div class="input-group mb-3">
		            <div class="custom-file">
		                <input type="file" class="custom-file-input" id="inputGroupFile03">
		                <label class="custom-file-label" for="inputGroupFile03">Choose file</label>
		            </div>
		        </div>
		    </div>
		    <div class="container py-3">
		        <img class="selected-image" id="view-image-area">
		    </div>
			<%
		}
	}
%>
</body>
</html>
