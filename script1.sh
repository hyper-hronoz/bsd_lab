#!/bin/sh
ipfw -q -f flush

# 1. Разрешаем localhost
ipfw add 100 allow ip from any to any via lo0

# 2. Запрет фрагментированных пакетов
ipfw add 110 deny all from any to any frag

# 3. Разрешаем уже установленные соединения
ipfw add 120 check-state
ipfw add 130 allow tcp from any to any established

# 4. Запрещаем входящие TCP-соединения, если они не соответствуют состоянию
ipfw add 140 deny tcp from any to me in

# 5. Разрешаем исходящий HTTP-трафик с установлением состояния
ipfw add 150 allow tcp from me to any 80 out via em0 keep-state

# 6. Разрешаем DNS-запросы к 8.8.8.8 (UDP и TCP)
ipfw add 160 allow udp from me to 8.8.8.8 53 keep-state
ipfw add 170 allow tcp from me to 8.8.8.8 53 keep-state

# 7. Блокируем всё остальное
ipfw add 65535 deny ip from any to any
