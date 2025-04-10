#!/bin/sh
# Очистить все старые правила
ipfw -q -f flush

# 1. Разрешить весь трафик через интерфейс loopback (lo0)
ipfw add 100 allow ip from any to any via lo0

# 2. Проверка существующих состояний соединений
ipfw add 110 check-state

# 3. Разрешить исходящий HTTP-трафик (порт 80) с сохранением состояния
ipfw add 120 allow tcp from me to any 80 out keep-state

# 4. Разрешить исходящий HTTPS-трафик (порт 443) с сохранением состояния
ipfw add 130 allow tcp from me to any 443 out keep-state

# 5. Разрешить исходящий DNS-запрос (порт 53 по UDP)
ipfw add 140 allow udp from me to any 53 out keep-state

# 6. Всё остальное запрещено и логируется (deny log)
ipfw add 65534 deny log ip from any to any

# 7. Логирование заблокированных пакетов (в /var/log/security)
# Это будет происходить для всех попыток, которые не попадают в предыдущие правила
