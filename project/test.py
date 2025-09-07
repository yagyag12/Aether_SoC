#!/usr/bin/env python3

import os
import sys
import subprocess
import glob

def run_simulation(tb_name, sources):

    # Step 2: Compile with Icarus Verilog
    compile_cmd = f"iverilog -o simv {tb_name} {' '.join(sources)}"
    print(f"Compiling: {compile_cmd}")
    compile_result = subprocess.run(compile_cmd, shell=True)

    if compile_result.returncode != 0:
        print("Error: Compilation failed.")
        sys.exit(1)

    # Step 3: Run the simulation and ensure it completes
    run_cmd = "./simv"
    print(f"Running: {run_cmd}")
    run_result = subprocess.run(run_cmd, shell=True)

    if run_result.returncode != 0:
        print("Error: Simulation execution failed.")
        sys.exit(1)

    # Step 4: Detect the generated VCD file immediately after simulation
    vcd_files = glob.glob("*.vcd")
    if not vcd_files:
        print("Error: No VCD file found. Ensure your testbench generates a VCD file using $dumpfile.")
        sys.exit(1)

    vcd_file = vcd_files[0]  # Use the first detected VCD file
    print(f"Detected VCD file: {vcd_file}")

    print("VCD file is ready. Opening GTKWave...")

    # Step 5: Open GTKWave with the detected VCD file
    gtkwave_cmd = f"gtkwave {vcd_file}"
    subprocess.run(gtkwave_cmd, shell=True)

if __name__ == "__main__":
    if len(sys.argv) < 3:
        print("Usage: python3 test.py <testbench.v> <source1.v> <source2.v> ...")
        sys.exit(1)

    tb_file = sys.argv[1]      # Testbench file
    sources = sys.argv[2:]     # Source files

    run_simulation(tb_file, sources)

