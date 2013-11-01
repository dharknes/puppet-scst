Facter.add(:scst_version) do
  confine :operatingsystem => %w{RedHat Centos}
  setcode do
    if File.exists?('/sys/kernel/scst_tgt/version')
        cmd = "/usr/bin/head -1 /sys/kernel/scst_tgt/version"
        version = Facter::Util::Resolution.exec(cmd)

        if version.nil? or !version.match(/\d+\.\d+/)
            nil
        else
            version
        end
    else
        nil
    end
  end
end

