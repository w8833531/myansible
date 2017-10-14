# Common

[![Ansible Galaxy][galaxy_image]][galaxy_link]
[![Build Status][travis_image]][travis_link]
[![Latest tag][tag_image]][tag_url]
[![Gitter chat][gitter_image]][gitter_url]

A role for common server settings

**Under construction!**

## Requirements

- Hosts should be bootstrapped for ansible usage (have python,...)
- Root privileges, eg `become: yes`
- `useradd`, `userdel` and `usermod` should be available on the host
- sudo should be available **(attention: this role will enable sudoers.d if not
  enabled)**

## Role Variables


## Dependencies
- [GROG.management-user][grog.management-user]
- [GROG.debug][grog.debug]
- [GROG.package][grog.package]
- [GROG.fqdn][grog.fqdn]
- [willshersystems.sshd][willshersystems.sshd]
- [yatesr.timezone][yatesr.timezone]

## Example Playbook

## Author
By [G. Roggemans][groggemans]

## License
MIT

[galaxy_image]:         https://img.shields.io/badge/galaxy-GROG.common-660198.svg?style=flat
[galaxy_link]:          https://galaxy.ansible.com/GROG/common
[travis_image]:         https://travis-ci.org/GROG/ansible-role-common.svg?branch=master
[travis_link]:          https://travis-ci.org/GROG/ansible-role-common
[tag_image]:            https://img.shields.io/github/tag/GROG/ansible-role-common.svg
[tag_url]:              https://github.com/GROG/ansible-role-common/tags
[gitter_image]:         https://badges.gitter.im/GROG/chat.svg
[gitter_url]:           https://gitter.im/GROG/chat

[grog.management-user]: https://galaxy.ansible.com/GROG/management-user
[grog.debug]:           https://galaxy.ansible.com/GROG/debug
[grog.package]:         https://galaxy.ansible.com/GROG/package
[grog.fqdn]:            https://galaxy.ansible.com/GROG/fqdn
[willshersystems.sshd]: https://galaxy.ansible.com/willshersystems/sshd
[yatesr.timezone]:      https://galaxy.ansible.com/yatesr/timezone

[groggemans]:           https://github.com/groggemans
