/**
 *	@group Strings
 *	@description Common String utilities
 */
global class StringUtils {

	//PRIVATE MEMBERS

	private final static String CLASS_NAME = 'StringUtils';
	private final static String ALPHA_CHARS = 'abcdefghijklmnopqrstuvwxyz';
	private final static String ALLOWED_CHARS_WHITELIST = ALPHA_CHARS + ' ';
	private final static String SOSL_SPECIAL_CHARS_REGEX = '[|,|.|\\,||"||:|~|!|@|#|$|%|^|&|*|_|+|=|<|>|?|\\(|\\)|\\{|\\}|\\;|\\\'"]';

	//GLOBAL METHODS

	/**
	 *  @description 	Takes a given string and makes it proper name case (i.e. John Doe instead of JOHN DOE)
	 *  @param str 		The string to be converted to proper case
	 *  @return 		A string in proper case
	 */
	global static String toProperCase( String str ) {

		// if the string is null/empty, we want to return an empty string back
		if( String.isEmpty( str ) ) {
			return '';
		}

		// convert the string into lowercase
		String lowStr = StringUtils.noNulls( str ).toLowerCase();

		// split into words and capitalize the first letter of each
		List<String> stringBuffer = new List<String>();
		for( String s : lowStr.split( ' ' ) ) {
			stringBuffer.add( s.capitalize() );
		}

		// join the words back together and return the result
		return String.join( stringBuffer, ' ' );
	}

	/**
	 *  @description 	An overload of the properCase method that handles an array of strings. This is merely a convenience method.
	 *  @param strings 	The array of strings to be converted with properCase
	 *  @return 		The array with all strings converted to proper case
	 */
	global static List<String> toProperCase( List<String> strings ){
		List<String> properStrings = new List<String>();

		// if the parameter is null or empty, return an empty list back
		if( strings == null || strings.isEmpty() ) {
			return properStrings;
		}

		// loop through the array and propercase each entry
		for( String s : strings ) {
			properStrings.add(toProperCase(s));
		}

		return properStrings;
	}

	/**
	 *  @description "sanitizes" a given string by forcing both a no-nulls and a trim
	 *	@param	String to sanitize
	 *	@return A string that has been no-nulled and trimmed
	 */
	global static String sanitizeRequestParameter( String param ) {
		String sanitizedParam = StringUtils.noNulls(param).trim();
		return sanitizedParam;
	}

	/**
	 *	@description converts a null string to an empty string, ignores non-null strings
	 *	@param	Target string
	 *	@return The string if it is not null, otherwise an empty string
	 */
	global static String noNulls( String str ) {
		return str == null ? '' : str;
	}

	/**
	 *	@description "parses" the string, returning the default supplied if the target string is null or empty
	 *	@param	Target string
	 *	@param	Default in case of empy/null string
	 *	@return The string if it is not null, otherwise the supplied default
	 */
	global static String parseString( String myString, String defaultStr ) {
		if( String.isEmpty( myString ) ) {
			return defaultStr;
		} else {
			return myString;
		}
	}

	/**
	 *	@description attempt to parse an String to an Salesforce Id, returning null if it fails
	 *	@param	Target string
	 *	@return An actual ID, if it parsed properly. Otherwise, null.
	 */
	global static Id parseId( String myString ) {

		final String METHOD_NAME = 'parseId()';

		Id myId = null;
		try {
			myId = Id.valueOf( myString );
			Logger.logDebug( CLASS_NAME, METHOD_NAME, 'Using ID: ' + myId );
		} catch( Exception e ) {
			myId = null;
			Logger.logDebug( CLASS_NAME, METHOD_NAME, 'Found invalid ID, aborting...' );
		}

		return myId;
	}

	/**
	 *	@description attempt to parse an String to a boolean. If input is true (case-insensitive), it will return true, otherwise it will return false
	 *	@param	Target string
	 *	@return Result boolean
	 */
	global static Boolean parseBoolean( String myString ) {

		final String METHOD_NAME = 'parseBoolean()';

		try {
			return Boolean.valueOf(myString);
		}
		catch (System.NullPointerException ex) {
			return false;
		}
	}

	/**
	 *	@description converts a null Blob into an empty String, otherwise returns the blob-string
	 *	@param	Target blob
	 *	@return A string representation of the blob, otherwise an empty string if it is null
	 */
	global static String parseBlob( Blob b ) {
		return b == null ? '' : b.toString();
	}

	/**
	 *	@description generates a random string of the specified length
	 *	@param	Length of string to be generated
	 *	@return A string representation of the blob, otherwise an empty string if it is null
	 */
	global static String generateRandomString(Integer len) {

		String randStr = '';
		while (randStr.length() < len) {
			Integer idx = Math.mod(Math.abs(Crypto.getRandomInteger()), ALPHA_CHARS.length());
			randStr += ALPHA_CHARS.substring(idx, idx+1);
		}

		return randStr;
	}

	/**
	 *	@description remove special characters that are not part of a predefined whitelist
	 *	@param	Target string
	 *	@return Target string with non-whitelisted characters removed
	 */
	global static String stripChars( String source ) {
		final String METHOD_NAME = 'stripChars()';
		Logger.logDebug( CLASS_NAME, METHOD_NAME, 'Im here - stripAll' );

		return stripChars( source, null, true );
	}

	/**
	 *	@description remove the specified characters from the provided string
	 *	@param	Target string
	 *	@param	Specific characters to strip
	 *	@return Target string with specified characters removed
	 */
	global static String stripChars( String source, String charsToStrip ) {
		final String METHOD_NAME = 'stripChars()';
		Logger.logDebug( CLASS_NAME, METHOD_NAME, 'Im here - stripChars' );

		return stripChars( source, charsToStrip, false );
	}

	//PRIVATE METHODS//

	/**
	 *	@description private stripChars, handles both specified and all-chars scenarios for stripping characters
	 *	@param	Target string
	 *	@param	Specific characters to strip
	 *	@param	Boolean to strip all special characters
	 *	@return Target string with specified characters removed
	 */
	private static String stripChars( String source, String charsToStrip, Boolean stripAllSpecialChars ) {

		final String METHOD_NAME = 'stripChars()';
		Logger.logDebug( CLASS_NAME, METHOD_NAME, 'Im here - stripAll handler' );

		String strippedString = StringUtils.noNulls( source );

		if( stripAllSpecialChars ) {

			strippedString = '';

			for( Integer i = 0; i < source.length(); i++ ) {

				String currentChar = source.substring( i, i + 1 );

				Logger.logDebug( CLASS_NAME, METHOD_NAME, 'Working with char: ' + currentChar );

				if( ALLOWED_CHARS_WHITELIST.containsIgnoreCase( currentChar ) ) {
					strippedString += currentChar;
					Logger.logDebug( CLASS_NAME, METHOD_NAME, 'Allowed char: ' + currentChar );
				} else {
					// ignore this character and move on
					Logger.logDebug( CLASS_NAME, METHOD_NAME, 'Skipped char: ' + currentChar );
				}

				Logger.logDebug( CLASS_NAME, METHOD_NAME, 'String so far: ' + strippedString );
			}
		} else {

			if( !String.isEmpty( charsToStrip ) ) {
				// strip only the supplied chars
				for( Integer i = 0; i < charsToStrip.length(); i++ ) {
					String toStrip = charsToStrip.substring( i, i + 1 );

					strippedString = strippedString.remove( toStrip );
				}
			}
		}

		return strippedString;
	}

	/**
	 *	@description sanitize a string to match SOSL standard
	 *	@param	query input string to sanitize
	 *	@return sanitized string that matches SOSL standard
	 */
	global static String sanitizeSOSLQuery(String query) {
		if (query == null) {
			return null;
		}

		return query.replaceAll(SOSL_SPECIAL_CHARS_REGEX, '');
	}
}