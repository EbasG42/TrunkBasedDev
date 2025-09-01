
FROM ubuntu:22.04
RUN apt-get update && apt-get install -y --no-install-recommends \
    coreutils \
    && rm -rf /var/lib/apt/lists/*
WORKDIR /bench


RUN echo '#!/bin/bash\n\
echo "Escritura secuencial:"\n\
dd if=/dev/zero of=/bench/testfile bs=1M count=1024 oflag=direct 2>&1\n\
echo "Lectura secuencial:"\n\
dd if=/bench/testfile of=/dev/null bs=1M iflag=direct 2>&1\n\
rm -f /bench/testfile\n' > /usr/local/bin/run_benchmark.sh \
    && chmod +x /usr/local/bin/run_benchmark.sh


CMD ["bash", "/usr/local/bin/run_benchmark.sh"]
