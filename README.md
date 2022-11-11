# docker-dpdk

Try to build dpdk in the docker container to speed up development.

## Usage

DPDK is at `/home/dpdk`

### `dpdk-helloworld`

```bash
docker run -it -v /dev/hugepages:/dev/hugepages --privileged duskmoon/dpdk:22.07 /bin/bash

root@d8ddb5d8e69d:/home/app# cd ../dpdk/examples/helloworld/
root@d8ddb5d8e69d:/home/dpdk/examples/helloworld# make
cc -O3 -I/usr/local/include -include rte_config.h -march=native  -DALLOW_EXPERIMENTAL_API main.c -o build/helloworld-shared  -Wl,--as-needed -L/usr/local/lib/x86_64-linux-gnu -lrte_node -lrte_graph -lrte_flow_classify -lrte_pipeline -lrte_table -lrte_pdump -lrte_port -lrte_fib -lrte_ipsec -lrte_vhost -lrte_stack -lrte_security -lrte_sched -lrte_reorder -lrte_rib -lrte_dmadev -lrte_regexdev -lrte_rawdev -lrte_power -lrte_pcapng -lrte_member -lrte_lpm -lrte_latencystats -lrte_kni -lrte_jobstats -lrte_ip_frag -lrte_gso -lrte_gro -lrte_gpudev -lrte_eventdev -lrte_efd -lrte_distributor -lrte_cryptodev -lrte_compressdev -lrte_cfgfile -lrte_bpf -lrte_bitratestats -lrte_bbdev -lrte_acl -lrte_timer -lrte_hash -lrte_metrics -lrte_cmdline -lrte_pci -lrte_ethdev -lrte_meter -lrte_net -lrte_mbuf -lrte_mempool -lrte_rcu -lrte_ring -lrte_eal -lrte_telemetry -lrte_kvargs
ln -sf helloworld-shared build/helloworld
root@d8ddb5d8e69d:/home/dpdk/examples/helloworld# ./build/helloworld -l 0-3
EAL: Detected CPU lcores: 8
EAL: Detected NUMA nodes: 1
EAL: Detected shared linkage of DPDK
EAL: Multi-process socket /var/run/dpdk/rte/mp_socket
EAL: Selected IOVA mode 'VA'
EAL: VFIO support initialized
EAL: Using IOMMU type 1 (Type 1)
EAL: Ignore mapping IO port bar(2)
EAL: Probe PCI driver: net_ixgbe (8086:10fb) device: 0000:01:00.0 (socket 0)
EAL: Ignore mapping IO port bar(2)
EAL: Probe PCI driver: net_ixgbe (8086:10fb) device: 0000:01:00.1 (socket 0)
TELEMETRY: No legacy callbacks, legacy socket not created
hello from core 1
hello from core 2
hello from core 3
hello from core 0
root@d8ddb5d8e69d:/home/dpdk/examples/helloworld# exit
```
