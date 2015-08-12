=========================
saltstack-network-formula
=========================


.. image:: https://img.shields.io/badge/donate-flattr-red.svg
    :alt: Donate via flattr
    :target: https://flattr.com/profile/bechtoldt

.. image:: https://img.shields.io/gratipay/bechtoldt.svg
    :alt: Donate via Gratipay
    :target: https://www.gratipay.com/bechtoldt/

.. image:: https://img.shields.io/badge/license-Apache--2.0-blue.svg
    :alt: Apache-2.0-licensed
    :target: https://github.com/bechtoldt/saltstack-network-formula/blob/master/LICENSE

.. image:: https://img.shields.io/badge/chat-gitter-brightgreen.svg
    :alt: Join Gitter Chat
    :target: https://gitter.im/bechtoldt/saltstack-network-formula?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge

.. image:: https://img.shields.io/badge/chat-%23salt%20@%20Freenode-brightgreen.svg
    :alt: Join Internet Relay Chat
    :target: http://webchat.freenode.net/?channels=%23salt&uio=d4

SaltStack Formula to set up and configure a host's network configuration

.. contents::
    :backlinks: none
    :local:


Instructions
------------

Please refer to https://github.com/bechtoldt/formula-docs to learn how to use
this formula, how it is built and how you can add your changes.


**NOTICE:** This formula might uses the formhelper module which is a very useful Salt execution module that isn't available in upstream yet. Please consider retrieving it manually from https://github.com/bechtoldt/salt-modules and make it available to your Salt installation. Read `SaltStack documentation <http://docs.saltstack.com/en/latest/ref/modules/#modules-are-easy-to-write>`_ to see how this can be achieved.

Take a look at older releases (branches) to get a version that isn't using the formhelper yet (if any).



Contributing
------------

Contributions are welcome! All development guidelines we ask you to follow can
be found at https://github.com/bechtoldt/formula-docs.

In general:

1. Fork this repo on Github
2. Add changes, test them, update docs (README.rst) if possible
3. Submit your pull request (PR) on Github, wait for feedback

But it’s better to `file an issue <https://github.com/bechtoldt/saltstack-network-formula/issues/new>`_ with your idea first.


TODO
----

* add instructions how to use formhelper, add information about it in the formula-docs (dependency), show up alternative?
* table/ matrix: os/salt compatibility (dedicated file)
* add list of available states
* add tests
* Use more of the available options in interfaces.sls of network.managed
* interfaces: configure broadcast if set
* rewrite using #!py renderer


Authors
-------

* Alan Pearce <alan@alanpearce.co.uk>
* Arnold Bechtoldt <mail@arnoldbechtoldt.com>
* Krzysztof Pawłowski <krzysztof.pawlowski@firma.interia.pl>
* René Jochum <rene@jochums.at>
* Simon Lloyd <simon@slloyd.net>
* root <root@saltmaster01.(none)>


Miscellaneous
-------------

Recommended formulas:

* SaltStack management: `saltstack-salt-formula <https://github.com/bechtoldt/saltstack-salt-formula>`_

Further reading:

* Documentation and Standardisation of SaltStack formulas: https://github.com/bechtoldt/formula-docs
