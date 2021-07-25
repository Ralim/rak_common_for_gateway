#! /bin/bash
SX1301_W_DISABLE_PIN=229
SX1301_PWRKEY_PIN=72
SX1301_RESET_PIN=71

# Export all of the pins
[[ -d "/sys/class/gpio/gpio$SX1301_W_DISABLE_PIN/" ]] || echo "$SX1301_W_DISABLE_PIN"  > /sys/class/gpio/export
[[ -d "/sys/class/gpio/gpio$SX1301_PWRKEY_PIN/" ]] || echo "$SX1301_PWRKEY_PIN"  > /sys/class/gpio/export
[[ -d "/sys/class/gpio/gpio$SX1301_RESET_PIN/" ]] || echo "$SX1301_RESET_PIN"  > /sys/class/gpio/export
# Set all pins to outputs
echo "out" > /sys/class/gpio/gpio$SX1301_W_DISABLE_PIN/direction
echo "out" > /sys/class/gpio/gpio$SX1301_PWRKEY_PIN/direction
echo "out" > /sys/class/gpio/gpio$SX1301_RESET_PIN/direction
echo "0"   > /sys/class/gpio/gpio$SX1301_W_DISABLE_PIN/value
echo "0"   > /sys/class/gpio/gpio$SX1301_PWRKEY_PIN/value
echo "1"   > /sys/class/gpio/gpio$SX1301_RESET_PIN/value

# Pulse wireless disable signal
echo "0"   > /sys/class/gpio/gpio$SX1301_W_DISABLE_PIN/value
sleep 0.5
echo "1"   > /sys/class/gpio/gpio$SX1301_W_DISABLE_PIN/value
sleep 0.2
echo "0"   > /sys/class/gpio/gpio$SX1301_W_DISABLE_PIN/value
sleep 0.5
# Pulse pwr
echo "0"   > /sys/class/gpio/gpio$SX1301_PWRKEY_PIN/value
sleep 0.5
echo "1"   > /sys/class/gpio/gpio$SX1301_PWRKEY_PIN/value
sleep 0.2
echo "0"   > /sys/class/gpio/gpio$SX1301_PWRKEY_PIN/value
sleep 0.5


# Pulse reset
echo "1"   > /sys/class/gpio/gpio$SX1301_RESET_PIN/value
sleep 0.1
echo "0"   > /sys/class/gpio/gpio$SX1301_RESET_PIN/value
sleep 0.1
echo "1"   > /sys/class/gpio/gpio$SX1301_RESET_PIN/value
sleep 2
./set_eui.sh
sleep 0.2
#./update_gwid.sh ./local_conf.json
sleep 0.5
#./lora_pkt_fwd
