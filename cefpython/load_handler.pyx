# Copyright (c) 2012 CefPython Authors. All rights reserved.
# License: New BSD License.
# Website: http://code.google.com/p/cefpython/

cdef public void LoadHandler_OnLoadEnd(
        CefRefPtr[CefBrowser] cefBrowser,
        CefRefPtr[CefFrame] cefFrame,
        int httpStatusCode
        ) except * with gil:
    cdef PyBrowser pyBrowser
    cdef PyFrame pyFrame
    cdef object callback
    try:
        pyBrowser = GetPyBrowser(cefBrowser)
        pyFrame = GetPyFrame(cefFrame)
        callback = pyBrowser.GetClientCallback("OnLoadEnd")
        if callback:
            callback(pyBrowser, pyFrame, httpStatusCode)
    except:
        (exc_type, exc_value, exc_trace) = sys.exc_info()
        sys.excepthook(exc_type, exc_value, exc_trace)

cdef public void LoadHandler_OnLoadStart(
        CefRefPtr[CefBrowser] cefBrowser,
        CefRefPtr[CefFrame] cefFrame
        ) except * with gil:
    cdef PyBrowser pyBrowser
    cdef PyFrame pyFrame
    cdef object callback
    try:
        pyBrowser = GetPyBrowser(cefBrowser)
        pyFrame = GetPyFrame(cefFrame)
        callback = pyBrowser.GetClientCallback("OnLoadStart")
        if callback:
            callback(pyBrowser, pyFrame)
    except:
        (exc_type, exc_value, exc_trace) = sys.exc_info()
        sys.excepthook(exc_type, exc_value, exc_trace)

cdef public c_bool LoadHandler_OnLoadError(
        CefRefPtr[CefBrowser] cefBrowser,
        CefRefPtr[CefFrame] cefFrame,
        cef_types.cef_handler_errorcode_t cefErrorCode,
        CefString& cefFailedUrl,
        CefString& cefErrorText
        ) except * with gil:
    cdef PyBrowser pyBrowser
    cdef PyFrame pyFrame
    cdef str pyFailedUrl
    cdef object callback
    cdef list errorText
    cdef py_bool ret
    try:
        pyBrowser = GetPyBrowser(cefBrowser)
        pyFrame = GetPyFrame(cefFrame)
        pyFailedUrl = CefToPyString(cefFailedUrl)
        callback = pyBrowser.GetClientCallback("OnLoadError")
        if callback:
            errorText = [""]
            ret = callback(
                    pyBrowser, pyFrame, cefErrorCode, pyFailedUrl, errorText)
            if ret:
                PyToCefString(errorText[0], cefErrorText)
            return bool(ret)
        else:
            return False
    except:
        (exc_type, exc_value, exc_trace) = sys.exc_info()
        sys.excepthook(exc_type, exc_value, exc_trace)

# Network error constants.
ERR_FAILED = cef_types.ERR_FAILED
ERR_ABORTED = cef_types.ERR_ABORTED
ERR_INVALID_ARGUMENT = cef_types.ERR_INVALID_ARGUMENT
ERR_INVALID_HANDLE = cef_types.ERR_INVALID_HANDLE
ERR_FILE_NOT_FOUND = cef_types.ERR_FILE_NOT_FOUND
ERR_TIMED_OUT = cef_types.ERR_TIMED_OUT
ERR_FILE_TOO_BIG = cef_types.ERR_FILE_TOO_BIG
ERR_UNEXPECTED = cef_types.ERR_UNEXPECTED
ERR_ACCESS_DENIED = cef_types.ERR_ACCESS_DENIED
ERR_NOT_IMPLEMENTED = cef_types.ERR_NOT_IMPLEMENTED
ERR_CONNECTION_CLOSED = cef_types.ERR_CONNECTION_CLOSED
ERR_CONNECTION_RESET = cef_types.ERR_CONNECTION_RESET
ERR_CONNECTION_REFUSED = cef_types.ERR_CONNECTION_REFUSED
ERR_CONNECTION_ABORTED = cef_types.ERR_CONNECTION_ABORTED
ERR_CONNECTION_FAILED = cef_types.ERR_CONNECTION_FAILED
ERR_NAME_NOT_RESOLVED = cef_types.ERR_NAME_NOT_RESOLVED
ERR_INTERNET_DISCONNECTED = cef_types.ERR_INTERNET_DISCONNECTED
ERR_SSL_PROTOCOL_ERROR = cef_types.ERR_SSL_PROTOCOL_ERROR
ERR_ADDRESS_INVALID = cef_types.ERR_ADDRESS_INVALID
ERR_ADDRESS_UNREACHABLE = cef_types.ERR_ADDRESS_UNREACHABLE
ERR_SSL_CLIENT_AUTH_CERT_NEEDED = cef_types.ERR_SSL_CLIENT_AUTH_CERT_NEEDED
ERR_TUNNEL_CONNECTION_FAILED = cef_types.ERR_TUNNEL_CONNECTION_FAILED
ERR_NO_SSL_VERSIONS_ENABLED = cef_types.ERR_NO_SSL_VERSIONS_ENABLED
ERR_SSL_VERSION_OR_CIPHER_MISMATCH = cef_types.ERR_SSL_VERSION_OR_CIPHER_MISMATCH
ERR_SSL_RENEGOTIATION_REQUESTED = cef_types.ERR_SSL_RENEGOTIATION_REQUESTED
ERR_CERT_COMMON_NAME_INVALID = cef_types.ERR_CERT_COMMON_NAME_INVALID
ERR_CERT_DATE_INVALID = cef_types.ERR_CERT_DATE_INVALID
ERR_CERT_AUTHORITY_INVALID = cef_types.ERR_CERT_AUTHORITY_INVALID
ERR_CERT_CONTAINS_ERRORS = cef_types.ERR_CERT_CONTAINS_ERRORS
ERR_CERT_NO_REVOCATION_MECHANISM = cef_types.ERR_CERT_NO_REVOCATION_MECHANISM
ERR_CERT_UNABLE_TO_CHECK_REVOCATION = cef_types.ERR_CERT_UNABLE_TO_CHECK_REVOCATION
ERR_CERT_REVOKED = cef_types.ERR_CERT_REVOKED
ERR_CERT_INVALID = cef_types.ERR_CERT_INVALID
ERR_CERT_END = cef_types.ERR_CERT_END
ERR_INVALID_URL = cef_types.ERR_INVALID_URL
ERR_DISALLOWED_URL_SCHEME = cef_types.ERR_DISALLOWED_URL_SCHEME
ERR_UNKNOWN_URL_SCHEME = cef_types.ERR_UNKNOWN_URL_SCHEME
ERR_TOO_MANY_REDIRECTS = cef_types.ERR_TOO_MANY_REDIRECTS
ERR_UNSAFE_REDIRECT = cef_types.ERR_UNSAFE_REDIRECT
ERR_UNSAFE_PORT = cef_types.ERR_UNSAFE_PORT
ERR_INVALID_RESPONSE = cef_types.ERR_INVALID_RESPONSE
ERR_INVALID_CHUNKED_ENCODING = cef_types.ERR_INVALID_CHUNKED_ENCODING
ERR_METHOD_NOT_SUPPORTED = cef_types.ERR_METHOD_NOT_SUPPORTED
ERR_UNEXPECTED_PROXY_AUTH = cef_types.ERR_UNEXPECTED_PROXY_AUTH
ERR_EMPTY_RESPONSE = cef_types.ERR_EMPTY_RESPONSE
ERR_RESPONSE_HEADERS_TOO_BIG = cef_types.ERR_RESPONSE_HEADERS_TOO_BIG
ERR_CACHE_MISS = cef_types.ERR_CACHE_MISS
ERR_INSECURE_RESPONSE = cef_types.ERR_INSECURE_RESPONSE
