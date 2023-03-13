const apiUrl = 'http://localhost:8000/api/';
const usersAPIUrl = '${apiUrl}auth/users/';
const signUpAPIUrl = usersAPIUrl;
const logInAPIUrl = '${apiUrl}auth/login/';
const passwordResetAPIUrl = '${apiUrl}auth/passwordreset/';
const confirmPasswordResetAPIUrl = '${apiUrl}auth/passwordresetconfirm/';
const sendEmailVerificationAPIUrl = '${apiUrl}auth/sendemailverification/';
const verifyEmailAPIUrl = '${apiUrl}auth/verifyemail/';
const mobileAuthTokenAPIUrl = '${apiUrl}auth/mobiletoken/';
const verifyMobileAuthTokenAPIUrl = '${mobileAuthTokenAPIUrl}verify/';

const getProfileAPIUrl = '${apiUrl}profile/uid/';
const getProfilePictureAPIUrl = '${apiUrl}profile/picture/uid/';
