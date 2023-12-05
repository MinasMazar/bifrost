(require 'websocket)

(defvar bifrost-endpoint "ws://localhost:9069/bifrost"
  "Endpoint of bifrost elixir application")

(defun bifrost-start ()
  "Start webserver connection to Bifrost (Elixir WS server)"
  (interactive)
  (setq bifrost--websocket
        (websocket-open
         bifrost-endpoint
         :on-message
         (lambda (_websocket frame)
           (let ((body (websocket-frame-text frame)))
             (bifrost-eval body)))
             ;(message "[bifrost] message received: %S" body)))
         :on-close (lambda (_websocket) (message "websocket closed")))))

(defun bifrost-send (payload)
  (interactive "sMessage: ")
  (unless (bifrost-open-connection)
    (bifrost-start))
  (websocket-send-text bifrost--websocket payload))

(defun bifrost-open-connection ()
  (websocket-openp bifrost--websocket))

(defun bifrost-eval (string)
  "Evaluate elisp code stored in a string."
  (eval (car (read-from-string string))))

(defun bifrost--pong ()
  (bifrost-send "bifrost-pong"))

