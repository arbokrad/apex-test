/**
 *	@group Strings
 *	@description Tests for StringUtils
 */
@isTest
private without sharing class TEST_StringUtils {

	static final String PROPER = 'Hello World';
	static final String UPPER = 'HELLO WORLD';
	static final String LOWER = 'hello world';

	//
	//	toProperCase - test toProperCase with a null string
	//
	@isTest
	static void testProperCaseNullParam() {
		String testStr = null;
		System.assertEquals( '', StringUtils.toProperCase( testStr ) );
	}

	//
	//	toProperCase - test toProperCase with an empty string
	//
	@isTest
	static void testProperCaseEmptyParam() {
		System.assertEquals( '', StringUtils.toProperCase( '' ) );
	}

	//
	//  toProperCase - test properCase with an upper case string
	//
	@isTest
	static void testProperCaseWithUpperCase(){
		System.assertEquals( PROPER, StringUtils.toProperCase(UPPER) );
	}

	//
	//  toProperCase - test properCase with a lower case string
	//
	@isTest
	static void testProperCaseWithLowerCase(){
		System.assertEquals( PROPER, StringUtils.toProperCase(LOWER) );
	}

	//
	//  toProperCase - test properCase with a single lower case word
	//
	@isTest
	static void testProperCaseWithOneWord() {
		System.assertEquals( 'Hello', StringUtils.toProperCase( 'hello' ) );
	}

	//
	//  toProperCase - test properCase with a properCase string (should be no change)
	//
	@isTest
	static void testProperCaseWithProperCase() {
		System.assertEquals( PROPER, StringUtils.toProperCase( PROPER ) );
	}

	//
	//	toProperCase - test toProperCase with a null array
	//
	@isTest
	static void testProperCaseWithArrayNullParam() {
		List<String> testStrList = null;
		System.assert( StringUtils.toProperCase( testStrList ).isEmpty() );
	}

	//
	//	toProperCase - test toProperCase with an empty array
	//
	@isTest
	static void testProperCaseWithArrayEmptyParam() {
		List<String> testStrList = new List<String>();
		System.assert( StringUtils.toProperCase( testStrList ).isEmpty() );
	}


	//
	//  toProperCase - test properCase with an array of strings
	//
	@isTest
	static void testProperCaseWithArray() {
		List<String> strings = new List<String>{ LOWER,UPPER,PROPER };
		List<String> expected = new List<String>{ PROPER,PROPER,PROPER };
		System.assertEquals( expected, StringUtils.toProperCase( strings ) );
	}

	//
	// toProperCase - test properCase with Empty Array
	//
	@isTest
	static void testProperCaseWithEmptyArray(){
		System.assertEquals( new List<String>(), StringUtils.toProperCase( new List<String>() ) );
	}

	//
	// toProperCase - test properCase with special characters
	//
	@isTest
	static void testProperCaseWithSpecials() {
		System.assertEquals( 'Hello & G00dbye! @#$%^&*()_=-', StringUtils.toProperCase( 'hello & g00dbye! @#$%^&*()_=-' ) );
	}

	//
	// toProperCase - test properCase with an escaped character
	//
	@isTest
	static void testProperCaseWithEscapedCharacter() {
		System.assertEquals( 'Hello \n Goodbye', StringUtils.toProperCase( 'hello \n goodbye' ) );
	}

	//
	// toProperCase - test properCase with an empty string
	//
	@isTest
	static void testProperCaseWithEmptyString() {
		System.assertEquals( '', StringUtils.toProperCase( '' ) );
	}

	//
	// toProperCase - test properCase with a null value
	//
	@isTest
	static void testProperCaseWithNull() {
		String nullValue = null;
		System.assertEquals( '', StringUtils.toProperCase( nullValue ) );
	}

	//
	//	sanitizeRequestParams - test sanitizing request parameters (no-nulls and trim)
	//
	@isTest
	static void testSanitizeRequestParamsWithNormalString() {

		// test a normal string
		System.assertEquals( PROPER, StringUtils.sanitizeRequestParameter(PROPER) );
	}

	//
	//	sanitizeRequestParams - test trimming leading and trailing spaces
	//
	@isTest
	static void testSanitizeRequestParamsWithSpaces() {

		// test stripping out leading and trailing characters
		final String testParam = '   Hello World    ';
		System.assertEquals( PROPER, StringUtils.sanitizeRequestParameter(testParam) );
	}

	//
	//	sanitizeRequestParams - test all spaces
	//
	@isTest
	static void testSanitizeRequestParamsAllSpaces() {

		// test stripping out all characters
		final String testParam = '      ';
		System.assertEquals( '', StringUtils.sanitizeRequestParameter(testParam) );
	}

	//
	//	sanitizeRequestParams - test nulls
	//
	@isTest
	static void testSanitizeRequestParamsNull() {
		// test nulls
		final String testParam = null;
		System.assertEquals( '', StringUtils.sanitizeRequestParameter(testParam) );
	}

	//
	//	noNulls - test normal string
	//
	@isTest
	static void testNoNullsNormalString() {
		String testStr = StringUtils.noNulls(PROPER);
		System.assertEquals( PROPER, testStr );
	}

	//
	//	noNulls - test null values
	//
	@isTest
	static void testNoNullsWithNull() {
		final String testStr = StringUtils.noNulls(null);
		System.assertEquals( '', testStr );
	}

	//
	//	parseBlob - test null value
	//
	@isTest
	static void testParseBlobNullValue() {

		final Blob NULL_BLOB = null;
		String nullStr = StringUtils.parseBlob( NULL_BLOB );
		System.assertNotEquals( null, nullStr );
		System.assertEquals( '', nullStr );
	}

	//
	//	parseBlob - test normal blob
	//
	@isTest
	static void testParseBlobNormalBloc() {

		final Blob REAL_BLOB = Blob.valueOf( 'HELLO WORLD' );
		String realStr = StringUtils.parseBlob( REAL_BLOB );
		System.assertEquals( REAL_BLOB.toString(), realStr );
	}

	//
	//	generateRandomString - test null length parameter
	//
	@isTest
	static void testGenerateRandomStringNullParam() {

		// test a null length
		String rand3 = StringUtils.generateRandomString( null );
		System.assert( String.isEmpty(rand3) );
	}

	//
	//	generateRandomString - test negative length parameter
	//
	@isTest
	static void testGenerateRandomStringNegativeParam() {

		// test a invalid length
		String rand2 = StringUtils.generateRandomString( -1 );
		System.assert( String.isEmpty(rand2) );
	}

	//
	//	generateRandomString - test normal length string generation
	//
	@isTest
	static void testGenerateRandomStringNormalLength() {

		// test that the string generated is the correct length
		String rand1 = StringUtils.generateRandomString( 10 );
		System.assertEquals( 10, rand1.length() );
	}


	//
	//	stripChars - null target string
	//
	@isTest
	static void testStripCharsNullTarget() {

		String testStr = StringUtils.stripChars( null, '' );
		System.assertEquals( '', testStr );
	}

	//
	//	stripChars - empty target string
	//
	@isTest
	static void testStripCharsEmptyTarget() {

		String testStr = StringUtils.stripChars( '', '' );
		System.assertEquals( '', testStr );
	}

	//
	//	stripChars - null chars-to-strip
	//
	@isTest
	static void testStripCharsNullCharsToStrip() {

		String testStr = StringUtils.stripChars( 'ASDF', null );
		System.assertEquals( 'ASDF', testStr );
	}

	//
	//	stripChars - empty chars-to-strip
	//
	@isTest
	static void testStripCharsEmptyCharsToStrip() {

		String testStr = StringUtils.stripChars( 'ASDF', '' );
		System.assertEquals( 'ASDF', testStr );
	}

	//
	//	stripChars - no special characters in target string
	//
	@isTest
	static void testStripCharsNoCharMatches() {

		String testStr = StringUtils.stripChars( 'ASDF', '.' );
		System.assertEquals( 'ASDF', testStr );
	}

	//
	//	stripChars - remove special chars
	//
	@isTest
	static void testStripCharsSuccessfulRemoval() {

		String phone4 = StringUtils.stripChars('(111).222-3333', '-. ()' );
		System.assertEquals( '1112223333', phone4 );

	}

	//
	//	stripChars - stripAll no changes
	//
	@isTest
	static void testStripCharsAllNoChanges() {

		String noChanges = StringUtils.stripChars( 'The quick brown fox' );
		System.assertEquals( 'The quick brown fox', noChanges );

	}

	//
	//	stripChars - stripAll no changes
	//
	@isTest
	static void testStripCharsAllSuccessfulRemoval() {

		String removedChars = StringUtils.stripChars('The. quick- brown fox!@#$%^&*()_=-');
		System.assertEquals( 'The quick brown fox', removedChars);
	}

	//
	//	parseString - null target
	//
	@isTest
	static void testParseStringNullTarget() {

		String parsedStr = StringUtils.parseString( null, 'Hello World' );
		System.assertEquals( 'Hello World', parsedStr );
	}

	//
	//	parseString - empty target
	//
	@isTest
	static void testParseStringEmptyTarget() {

		String parsedStr = StringUtils.parseString( '', 'Hello World' );
		System.assertEquals( 'Hello World', parsedStr );
	}

	//
	//	parseString - null default
	//
	@isTest
	static void testParseStringNullDefault() {

		String parsedStr = StringUtils.parseString( '', null );
		System.assertEquals( null, parsedStr );
	}

	//
	//	parseString - empty default
	//
	@isTest
	static void testParseStringEmptyDefault() {

		String parsedStr = StringUtils.parseString( '', '' );
		System.assertEquals( '', parsedStr );
	}

	//
	//	parseString - fallback to default
	//
	@isTest
	static void testParseStringFallbackToDefault() {

		String parsedStr = StringUtils.parseString( '', 'Hello World' );
		System.assertEquals( 'Hello World', parsedStr );
	}

	//
	//	parseString - no fallback
	//
	@isTest
	static void testParseStringNoFallback() {

		String parsedStr = StringUtils.parseString( 'ASDF', 'Hello World' );
		System.assertEquals( 'ASDF', parsedStr );
	}

	//
	//	parseId - null param
	//
	@isTest
	static void testParseIdNullParam() {

		Id parsedNullStrId = StringUtils.parseId( null );
		System.assertEquals( null, parsedNullStrId );
	}

	//
	//	parseId - empty param
	//
	@isTest
	static void testParseIdEmptyParam() {

		Id parsedNullStrId = StringUtils.parseId( '' );
		System.assertEquals( null, parsedNullStrId );
	}

	//
	//	parseId - invalid Id
	//
	@isTest
	static void testParseIdInvalidParam() {

		Id parsedNullStrId = StringUtils.parseId( '123456789012345' );
		System.assertEquals( null, parsedNullStrId );
	}

	//
	//	parseId - real Id
	//
	@isTest
	static void testParseIdSuccessfulParse() {

		Account a = new Account();
		a.Name = 'UNIT_TEST_PARSEID';
		insert a;

		Id parsedGoodId = StringUtils.parseId( a.Id );
		System.assertEquals( a.Id, parsedGoodId );
	}

	//
	//	parseBoolean - null param
	//
	@isTest
	static void testParseBooleanNullParam() {

		Boolean parsedNullStrBoolean = StringUtils.parseBoolean( null );
		System.assertEquals( false, parsedNullStrBoolean );
	}

	//
	//	parseBoolean - empty param
	//
	@isTest
	static void testParseBooleanEmptyParam() {

		Boolean parsedNullStrBoolean = StringUtils.parseBoolean( '' );
		System.assertEquals( false, parsedNullStrBoolean );
	}

	//
	//	parseBoolean - invalid Boolean
	//
	@isTest
	static void testParseBooleanInvalidParam() {

		Boolean parsedNullStrBoolean = StringUtils.parseBoolean( '123456789012345' );
		System.assertEquals( false, parsedNullStrBoolean );
	}

	//
	//	parseBoolean - input integer 1
	//
	@isTest
	static void testParseBooleanInput1() {

		Boolean parsedNullStrBoolean = StringUtils.parseBoolean( '1' );
		System.assertEquals( false, parsedNullStrBoolean );
	}

	//
	//	parseBoolean - input integer 0
	//
	@isTest
	static void testParseBooleanInput0() {

		Boolean parsedNullStrBoolean = StringUtils.parseBoolean( '0' );
		System.assertEquals( false, parsedNullStrBoolean );
	}

	//
	//	parseBoolean - real Boolean - wrong case (True rather than true)
	//
	@isTest
	static void testParseBooleanTrueCapitalized() {
		Boolean parsedBoolean = StringUtils.parseBoolean( 'TRUE' );
		System.assertEquals( true, parsedBoolean );
	}

	//
	//	parseBoolean - real Boolean - good input for true
	//
	@isTest
	static void testParseBooleanTrue() {
		Boolean parsedBoolean = StringUtils.parseBoolean( 'true' );
		System.assertEquals( true, parsedBoolean );
	}

	//
	//	parseBoolean - real Boolean - false value
	//
	@isTest
	static void testParseBooleanFalseCapitalized() {
		Boolean parsedBoolean = StringUtils.parseBoolean( 'FALSE' );
		System.assertEquals( false, parsedBoolean );
	}

	//
	//	parseBoolean - real Boolean - false value
	//
	@isTest
	static void testParseBooleanFalse() {
		Boolean parsedBoolean = StringUtils.parseBoolean( 'false' );
		System.assertEquals( false, parsedBoolean );
	}

	//
	// test sanitize search query happy path with non-null input
	//
	@isTest
	static void testSanitizeSearchQueryHappyPath() {
		//[|,|.|\\,||"||:|~|!|@|#|$|%|^|&|*|_|+|=|<|>|?|\\(|\\)|\\{|\\}|\\;|\\\'"]
		String testString = 'T&,.":~!@E#$%*_S+=<>?;(){}T~';
		String sanitizedString = StringUtils.sanitizeSOSLQuery(testString);
		System.assertEquals('TEST', sanitizedString);
	}

	//
	// test sanitize search query with null input
	//
	@isTest
	static void testSanitizeSearchQueryNullInput() {
		String testString = null;
		String sanitizedString = StringUtils.sanitizeSOSLQuery(testString);
		System.assertEquals(null, sanitizedString);
	}

	//
	// test sanitize search query with empty input
	//
	@isTest
	static void testSanitizeSearchQueryEmptyInput() {
		String testString = '';
		String sanitizedString = StringUtils.sanitizeSOSLQuery(testString);
		System.assertEquals('', sanitizedString);
	}

}