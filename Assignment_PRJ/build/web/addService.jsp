<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Add service</title>
        <script src="https://cdn.tailwindcss.com"></script>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.min.css"
              integrity="sha512-xh6O/CkQoPOWDdYTDqeRdPCVd1SpvCA9XXcUnZS2FmJNp1coAFzvtCN9BmamE+4aHK8yyUHUSCcJHgXloTyT2A=="
              crossorigin="anonymous" referrerpolicy="no-referrer" />
        <style>
            body{
                background: #136a8a;
                background: -webkit-linear-gradient(to right, #267871, #136a8a);
                background: linear-gradient(to right, #267871, #136a8a);
            }

            form {
                background: #8e9eab;
                background: -webkit-linear-gradient(to right, #eef2f3, #8e9eab);
                background: linear-gradient(to right, #eef2f3, #8e9eab);
            }
        </style>
    </head>
    <body>
        <div class="root relative">
            <div class="back-profile mt-6 ml-6">
                <a href="managerService.jsp" class="text-3xl">
                    <i class="fa-solid fa-arrow-left text-black"></i> <span class="text-black">Managment Service</span>
                </a>
            </div>
            <center>
                <form action="create-service" method="post" enctype="multipart/form-data" class="max-w-3xl border-2 border-gray-400 rounded pb-10 shadow-2xl">
                    <table>
                        <tr class="h-10">
                            <th colspan="4">
                                <h1 class="text-5xl m-5">Add Service</h1>
                            </th>
                        </tr>
                        <tr class="h-10 text-lg">
                            <td colspan="2">Name: </td>
                            <td colspan="2">
                                <input class="border-2 rounded w-full px-2" name="name" value="${requestScope.name}" style="width: 100%;"/>
                            </td>
                        </tr>
                        <c:if test="${requestScope.msgName != null}">
                            <tr class="text-base">
                                <td colspan="2"></td>
                                <td colspan="2">
                                    <span style="color:red;">${requestScope.msgName}</span>
                                </td>
                            </tr>
                        </c:if>
                        <tr class="h-10 text-lg">
                            <td colspan="2">Description: </td>
                            <td colspan="2">
                                <input type="text" class="border-2 rounded w-full px-2" name="description" value="${requestScope.description}"/>
                            </td>
                        </tr>
                        <c:if test="${requestScope.msgDescription != null}">
                            <tr class="text-base">
                                <td colspan="2"></td>
                                <td colspan="2">
                                    <span style="color:red;">${requestScope.msgDescription}</span>
                                </td>
                            </tr>
                        </c:if>
                        <tr class="h-10 text-lg">
                            <td colspan="2">Price: </td>
                            <td colspan="2">
                                <input type="text" class="border-2 rounded w-full px-2" name="price" value="${requestScope.price}"/>
                            </td>
                        </tr>
                        <c:if test="${requestScope.msgPrice != null}">
                            <tr class="text-base">
                                <td colspan="2"></td>
                                <td colspan="2">
                                    <span style="color:red;">${requestScope.msgPrice}</span>
                                </td>
                            </tr>
                        </c:if>
                        <tr class="h-10 text-lg">
                            <td colspan="2">Image: </td>
                            <td colspan="2">
                                <input type="file" name="file" class="cursor-pointer"/>
                            </td>
                        </tr>
                        <c:if test="${requestScope.msgImage != null}">
                            <tr class="text-base">
                                <td colspan="2"></td>
                                <td colspan="2">
                                    <span style="color:red;">${requestScope.msgImage}</span>
                                </td>
                            </tr>
                        </c:if>
                        <tr>
                            <td colspan="4">
                                <input type="submit" value="Create" class="w-full mt-2 py-2 bg-blue-700 rounded cursor-pointer text-white hover:bg-blue-600"/>         
                            </td>
                        </tr>
                        <c:if test="${requestScope.msgResultSuccess != null}">
                            <tr class="h-10 text-base">
                                <td colspan="4" class="text-green-600">
                                    ${requestScope.msgResultSuccess}
                                </td>
                            </tr>
                        </c:if>
                        <c:if test="${requestScope.msgResultFail != null}">
                            <tr class="h-10 text-base">
                                <td colspan="4" class="text-red-600">
                                    ${requestScope.msgResultFail}
                                </td>
                            </tr>
                        </c:if>
                    </table>
                </form>
            </center>
        </div>
    </body>
</html>
