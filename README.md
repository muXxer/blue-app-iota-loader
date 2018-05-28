# Load the IOTA app onto the Ledger Nano S
Environment to load the IOTA app onto the Ledger Nano S

Here we try to use natively available crypto logic to create IOTA Seeds and sign transactions on the fly. It's currently heavily in alpha so don't trust this yet!

See [blue-app-iota GitHub repository](https://github.com/IOTA-Ledger/blue-app-iota) for the original source code.

See [Ledger's documentation](http://ledger.readthedocs.io) to get more info about the inner workings.

## How to get started

### Requirements

- Make sure that your Ledger Nano S is running firmware 1.4.2.
For update instructions see: [How to update my Ledger Nano S with the firmware 1.4](https://support.ledgerwallet.com/hc/en-us/articles/360001340473-How-to-update-my-Ledger-Nano-S-with-the-firmware-1-4)

### Preparing environment under Debian and Ubuntu 

- Clone this repo
- Execute the following commands to setup your environment:
```
cd blue-app-iota-loader
./install_env.sh
```
- If you execute it for the first time, maybe you have to log out and log in again to get correct group rights

### Load the IOTA Ledger app

- Connect your Ledger to the PC and unlock it
- To load the app, be sure that the dashboard is opened in the Ledger
- Run the following command to load the pre-compiled app onto the Ledger
```
python download_app.py
```
- Accept all the messages on the Ledger

### Delete the IOTA Ledger app

- Connect your Ledger to the PC and unlock it
- To delete the app, be sure that the dashboard is opened in the Ledger
- Run the following command to delete the IOTA app on the Ledger
```
python delete_app.py
```
- Accept all the messages on the Ledger

## Documentation

See: [Ledger Nano S Web Wallet and APDU API Documentation](https://github.com/IOTA-Ledger/blue-app-iota/blob/master/Ledger%20Nano%20S%20Web%20Wallet%20and%20APDU%20API%20Documentation%20and%20implementation.md)

## Contributing

### Donations
Would you like to donate to help the development team? Send some IOTA to the following address:
```
J9KPGBTWIKTRBIWXNDCZUWWWVVESYVISFJIY9GCMGVLQXFJBDAKLLN9PNAZOOUZFZDGDSFPWCTJYILDF9WOEVDQVMY
```
Please know that the donations made to this address will be shared with everyone who contributes (the contributions has to be worth something, of course)

### As a developer
Would you like to contribute as a dev? Please check out our [Discord channel](https://discord.gg/U3qRjZj) to contact us!
