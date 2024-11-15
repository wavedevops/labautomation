To install `eksctl` on **RHEL 9** using the command you provided, follow these steps:

1. **Run the curl command to download the latest version of `eksctl`:**
   ```bash
   curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp
   ```

2. **Move the `eksctl` binary to `/usr/local/bin`:**
   ```bash
   sudo mv /tmp/eksctl /usr/local/bin
   ```

3. **Verify the installation:**
   ```bash
   eksctl version
   ```

These steps will download the latest version of `eksctl` for your system architecture (AMD64), extract it, and move it to a location in your system's `PATH` so that you can run `eksctl` from anywhere.

This process should work on **RHEL 9** as it is compatible with the `tar` and `curl` commands used in the steps.

For more detailed instructions, check the official [AWS documentation for eksctl](https://docs.aws.amazon.com/eks/latest/userguide/eksctl.html).