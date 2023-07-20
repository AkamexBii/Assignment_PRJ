<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>

    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login</title>
        <script src="https://cdn.tailwindcss.com"></script>
        <script src="https://smtpjs.com/v3/smtp.js"></script>
        <script type="text/javascript" src="https://cdn.jsdelivr.net/npm/@emailjs/browser@3/dist/email.min.js"></script>
        <script type="text/javascript">
            (function () {
                emailjs.init('y5DYtWt_QgPm5ie8w');
            })();
        </script>
        <style>
            .input input {
                background-color: #FFF6F4;
            }

            .container {
                background: radial-gradient(circle, rgba(238,174,202,1) 0%, rgba(148,187,233,1) 100%);
            }
        </style>
    </head>

    <body>
        <div class="flex items-center justify-center h-screen w-screen container">
            <form id="reset-form" action="resetpassword" method="post">
                <div class="bg-white w-96 p-6 rounded shadow-sm">
                    <div class="flex items-center justify-center mb-4">
                        <img src="./image/logo.png" alt="logo" class="h-32">
                    </div>
                    <h1 class="text-4xl font-semibold mb-6 text-orange-600">Reset password</h1>
                    <div class="input my-3">
                        <span class="block text-base font-medium text-slate-700">Username</span>
                        <input type="text" name="to_name" placeholder="Enter user name" class="w-full p-2"/>
                    </div>
                    <div class="input my-3">
                        <span class="enail-input block text-base font-medium text-slate-700">Email</span>
                        <input type="email" name="to_email" placeholder="Enter email" class="w-full p-2" />
                        <input type="hidden" name="from_name" placeholder="Enter email" class="w-full p-2" />
                        <input type="hidden" name="code" placeholder="Enter email" class="code w-full p-2" />
                    </div>
                    <div class="input my-3 code-input hidden">
                        <span class="block text-base font-medium text-slate-700">Code</span>
                        <input type="text" name="code-input" placeholder="Enter code" class="code-input w-full p-2"/>
                    </div>
                    <div class="input my-3 password-input hidden">
                        <span class="block text-base font-medium text-slate-700">New password</span>
                        <input type="text" name="password" placeholder="Enter new password" class="w-full p-2"/>
                    </div>
                    <div class="input my-3 re-password-input hidden">
                        <span class="block text-base font-medium text-slate-700">Confirm password</span>
                        <input type="text" name="rePassowrd" placeholder="Enter confirm new password" class="w-full p-2"/>
                    </div>
                    <div class="login-btn flex justify-center my-6">
                        <input
                            class="send-code-btn bg-orange-500 hover:bg-orange-600 active:bg-orange-700 w-28 p-2 rounded-xl cursor-pointer"
                            type="submit" value="Reset" />
                    </div>
                    <c:if test="${requestScope.newPass != null}">
                        <div class="input my-3">
                            <span class="block text-base font-medium text-slate-700">Your new password</span>
                            <input type="text" class="w-full p-2" value="${requestScope.newPass}"/>
                        </div>
                    </c:if>
                    <c:if test="${requestScope.resultSuccess != null}">
                        <span class="block text-green-600">${requestScope.resultSuccess}</span>
                    </c:if>
                    <c:if test="${requestScope.resultFaild != null}">
                        <span class="block text-red-500">${requestScope.resultFaild}</span>
                    </c:if>
                    <div class="sign-up flex justify-center items-center">
                        <span class="text-sm text-slate-700">Already have an account ? </span>
                        <a href="login.jsp" class="text-orange-500 ml-px">Sign in</a>
                    </div>
                </div>
            </form>
        </div>
    </body>

</html>
<script>
    const sendCodeBtn = document.querySelector('.send-code-btn');
    const code = document.querySelector('.code');

    window.onload = function () {
        document.querySelector('#reset-form').addEventListener('submit', function (e) {
            e.preventDefault();
            const emailInput = document.querySelector('.enail-input');

            let randomPin = Math.random().toString(36).substring(2, 8);
            
            this.from_name.value = "Smart_beauty";
            this.code.value = randomPin;

            const thiss = this;
            // these IDs from the previous steps
            emailjs.sendForm('service_swe9zgo', 'template_ijoomqg', this)
                    .then(function () {
                        console.log('SUCCESS!');
                        thiss.submit();
                    }, function (error) {
                        console.log('FAILED...', error);
                    });
        });
    }
</script>