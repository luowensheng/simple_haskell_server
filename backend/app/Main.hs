module Main where

import Network.Socket                            
import System.IO                                 

main :: IO ()                                    
main = do                                        
  sock <- socket AF_INET Stream 0                
  bind sock (SockAddrInet 4000 0)                
  listen sock 2                                  
  putStrLn "Listening on port 4000..."  
  run sock         


run sock = do 
  (conn, _) <- accept sock                       
  putStrLn "New connection accepted"             

  handleSock <- socketToHandle conn ReadWriteMode
  print conn

  line <- hGetLine handleSock                    
  putStrLn $ "Request received: " ++ line        
--   print handleSock    

  hPutStrLn handleSock $ "HTTP/1.1 200 OK\r\nContent-Type: text/html\r\n\r\n\r\n<html><head><title>Example</title></head><body><p>Worked!!!</p></body></html>"    -- create response writer    
  hClose handleSock   
  run sock


