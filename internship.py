#libraries
import xml.etree.ElementTree as XmlElementTree                                   #module for working with xml files
import httplib2                                                                  #HTTP client library
import uuid                                                                      #library for working with UUID
from config import ***                                                           #importing *** from config
 
#variables
***_HOST = '***'                                                                 #setting host
***_PATH = '/***_xml'                                                            #setting path
CHUNK_SIZE = 1024 ** 2                                                           #setting chunk size
 
#function transform speech to text and send POST request
def speech_to_text(filename=None, bytes=None, request_id=uuid.uuid4().hex, topic='notes', lang='ru-RU',
                   key=***_API_KEY):
  
#getting information from file
    if filename:                                                                 #if file exists
        with open(filename, 'br') as file:                                       #open file as binary and read
            bytes = file.read()                                                  #read all information from file
    if not bytes:                                                                #if file is empty
        raise Exception('Neither file name nor bytes provided.')                 #throwing exception
 
#converting bytes to pcm 1600 hz 16 bit for better recognize
    bytes = convert_to_pcm16b16000r(in_bytes=bytes)
 
#creating URL request to ***
    url = ***_PATH + '?uuid=%s&key=%s&topic=%s&lang=%s' % (                      #formating string
        request_id,                                                              #uuid = request_id is uuid.uuid4().hex
        key,                                                                     #key = key is ***_API_KEY
        topic,                                                                   #topic = topic is 'notes'
        lang                                                                     #lang = lang is 'ru-RU'
    )
 
#reading information by chunks from converted bytes
    chunks = read_chunks(CHUNK_SIZE, bytes)
 
#connecting to ***_HOST
    connection = httplib2.HTTPConnectionWithTimeout(***_HOST)

#creating request
    connection.connect()
    connection.putrequest('POST', url)                                          #set POST request
    connection.putheader('Transfer-Encoding', 'chunked')                        #set header Tranfer-Encoding
    connection.putheader('Content-Type', 'audio/x-pcm;bit=16;rate=16000')       #set header Content-Type
    connection.endheaders()                                                     #finish writing headers
 
#passing data by chunks
    for chunk in chunks:                                                        #for each chunk in chunks
        connection.send(('%s\r\n' % hex(len(chunk))[2:]).encode())              #sending size of chunk in hex
        connection.send(chunk)                                                  #sendind chunk data
        connection.send('\r\n'.encode())                                        #end of chunk
 
    connection.send('0\r\n\r\n'.encode())                                       #end of message
    response = connection.getresponse()                                         #getting response
 
#checking server response
    if response.code == 200:                                                    #if response is OK
        response_text = response.read()                                         #get HTML page
        xml = XmlElementTree.fromstring(response_text)                          #convert string to xml elem
 
        if int(xml.attrib['success']) == 1:
            max_confidence = - float("inf")                                     #set max_confidence minimum value
            text = ''                                                           #set variable text
 
#checking if everything is OK on HTML page
#finding child with maximum value of confidence
            for child in xml:                                                           #for each node in xml tree
                if float(child.attrib['confidence']) > max_confidence:                  #if child confidence > max_confidence
                    text = child.text                                                   #remember text of child
                    max_confidence = float(child.attrib['confidence'])                                          #make child max_confidence

            if max_confidence != - float("inf"):                                                                #if was found child
                return text                                                                                     #return text
            else:
                
                raise SpeechException('No text found.\n\nResponse:\n%s' % (response_text))                      #throw HTML page
        else:
            raise SpeechException('No text found.\n\nResponse:\n%s' % (response_text))                          #throw HTML page
    else:
        raise SpeechException('Unknown error.\nCode: %s\n\n%s' % (response.code, response.read()))              #server response is not 200(OK)
 
#class is empty
сlass SpeechException(Exception):
    pass


