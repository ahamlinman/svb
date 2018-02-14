# svb

svb is the Simple Volume Backup tool for Docker volumes. It's a small and
opinionated set of scripts designed to regularly back up Docker volumes to an
S3 bucket (and, of course, restore them later).

## Setup

Under the hood, svb uses the [AWS CLI] for all S3-related operations. This tool
must be configured as described in [Configuring the AWS CLI]. (It's relatively
flexible, and can use a config file or environment variables as needed.)

[AWS CLI]: https://aws.amazon.com/cli/
[Configuring the AWS CLI]: https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-getting-started.html

An example invocation of svb using a Docker container and environment variable
configuration (assuming the image is tagged `svb`) might look as follows:

```
docker run --rm \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -e AWS_ACCESS_KEY_ID=... \
  -e AWS_SECRET_ACCESS_KEY=... \
  -e AWS_DEFAULT_REGION=us-west-2 \
  svb create my-bucket my-first-volume my-second-volume ...
```

Alternatively, using an AWS CLI config file from your home directory:

```
docker run --rm \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -v "$HOME/.aws":/root/.aws \
  svb create my-bucket my-first-volume my-second-volume ...
```

## Usage

svb supports the following operations:

* Creating a backup of specified volumes to an S3 bucket. Each backup is a
  folder named with a UNIX timestamp. Volumes become .tar.gz archives within
  the folder.
* Restoring all volumes or a subset of volumes from a specified backup (folder)
  in an S3 bucket.
* Listing recent backups to a specified S3 bucket.

Full usage information can be obtained by running `svb help`.

## Caveats

* svb assumes that your volumes are in a safe state to be backed up. For some
  types of content (e.g. data files for certain databases), you may need to
  stop other containers from accessing the volume to prevent corrupted backups.

## License

MIT (see LICENSE.txt)
