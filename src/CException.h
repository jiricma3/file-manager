#ifndef __CEXEPTION_H__
#define __CEXEPTION_H__

#include <exception>

using namespace std;

/**
 * @brief Class for raising custom exceptions.
 * 
 * Throws exceptions when an unexpected entry or problem occurs.
 * 
 */
class CException : exception
{
    public:
        CException(const char * txt) : m_Txt(txt) {}
        ~CException() = default;

        /**
         * @brief Listing the text of an exception to standard output.
         * 
         * @return Text of an exception.
         */
        const char * what () const throw () { return m_Txt; }

    private:
        const char * m_Txt; ///< Returned exception text.
};

/**
 * @brief Class containing exception text.
 * 
 */
class CExTxt
{
    public:
        const char * DoesntExist = "Source file does not exist.";
        const char * AlreadyExists = "File already exists.";
        const char * IsNotAccessible = "File is not accessible.";
        const char * CouldNotCreateLink = "Could not create symbolic link. Link might already exist or target file is not accessible.";
        const char * CouldNotChangeDir = "Could not change working directory. Given path might not exist or given path is not a directory.";
        const char * CouldNotGetFsInfo = "Could not get filesystem information.";
        const char * CouldNotPrint = "Given file is a directory. Use \"list\" instead.";
        const char * CouldNotOpenFile = "Could not open file.";
};
#endif
