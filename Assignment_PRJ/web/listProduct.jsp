<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script src="https://cdn.tailwindcss.com"></script>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.min.css"
              integrity="sha512-xh6O/CkQoPOWDdYTDqeRdPCVd1SpvCA9XXcUnZS2FmJNp1coAFzvtCN9BmamE+4aHK8yyUHUSCcJHgXloTyT2A=="
              crossorigin="anonymous" referrerpolicy="no-referrer" />
        <title>JSP Page</title>
    </head>
    <body>
        <div class="root relative">
            <div class="back-profile mt-6 ml-6">
                <a href="product.jsp" class="text-3xl">
                    <i class="fa-solid fa-arrow-left text-black"></i> <span class="text-black">Product</span>
                </a>

                <div class="flex justify-center mt-10">
                    <div class="relative overflow-x-auto w-10/12">
                        <table class="w-full text-sm text-left text-gray-500 dark:text-gray-400">
                            <thead class="text-xs text-gray-700 uppercase bg-gray-50 dark:bg-gray-700 dark:text-gray-400">
                                <tr>
                                    <th scope="col" class="px-6 py-3">
                                        Product name
                                    </th>
                                    <th scope="col" class="px-6 py-3">
                                        Unit in stock
                                    </th>
                                    <th scope="col" class="px-6 py-3">
                                        Unit on order
                                    </th>
                                    <th scope="col" class="px-6 py-3">
                                        Price
                                    </th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach items="${requestScope.data}" var="p">
                                    <tr class="bg-white border-b dark:bg-gray-800 dark:border-gray-700">
                                        <th scope="row" class="px-6 py-4 font-medium text-gray-900 whitespace-nowrap dark:text-white">
                                            ${p.getName()}
                                        </th>
                                        <td class="px-6 py-4">
                                            ${p.getUnitInStock()}
                                        </td>
                                        <td class="px-6 py-4">
                                            ${p.getUnitOnOrder()}
                                        </td>
                                        <td class="px-6 py-4">
                                            ${p.getUnitPrice()}$
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>
