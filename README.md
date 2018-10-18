# svb

svb is the Simple Volume Backup tool – a small and opinionated set of Bash
scripts designed to back up Docker volumes as .tar.gz archives in an S3 bucket
(and, of course, restore them later).

## Features

svb supports the following operations:

* Creating a backup of specified volumes to an S3 bucket. Each backup is a
  folder named with a UNIX timestamp. Volumes become .tar.gz archives within
  the folder.
* Restoring all volumes or a subset of volumes from a specified backup (folder)
  in an S3 bucket.
* Listing recent backups to a specified S3 bucket.
* Downloading the archives for a specified backup and listing the files in them
  (to help you verify that the archives are readable and contain the expected
  content).

Full usage information can be obtained by running `svb help`.

## Usage

### AWS Setup

Under the hood, svb uses the [AWS CLI] for all S3-related operations. This tool
must be configured as described in [Configuring the AWS CLI]. It's relatively
flexible, and can use a config file or environment variables as needed.

[AWS CLI]: https://aws.amazon.com/cli/
[Configuring the AWS CLI]: https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-getting-started.html

### Running in a Docker Container

The latest version of svb is distributed as a Docker image on Docker Hub:
**ahamlinman/svb**. By bind-mounting your host's Docker socket as a volume, you
can run svb commands without installing any additional tools. This is the
preferred way to deploy and run svb.

An example invocation, using environment variable configuration for the AWS
CLI, might look as follows:

```shell
docker run --rm \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -e AWS_ACCESS_KEY_ID=... \
  -e AWS_SECRET_ACCESS_KEY=... \
  -e AWS_DEFAULT_REGION=us-west-2 \
  ahamlinman/svb create my-bucket my-volumes...
```

Alternatively, using an AWS CLI config file from your home directory:

```shell
docker run --rm \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -v "$HOME/.aws":/root/.aws \
  ahamlinman/svb create my-bucket my-volumes...
```

## Notes and Caveats

* All `tar` operations are performed in Busybox containers on the Docker host.
  Because of this, most svb operations automatically run `docker pull busybox`.
* svb assumes that your volumes are in a safe state to be backed up. For some
  types of content (e.g. data files for certain databases), you may need to
  stop other containers from accessing the volume to prevent corrupted backups.
  (This is not unique to svb.)

## License

MIT (see LICENSE.txt)
