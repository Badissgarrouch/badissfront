String getCardLogo(String cardName) {
  switch (cardName.toLowerCase()) {
    case 'visa': return 'assets/images/visa.PNG';
    case 'mastercard': return 'assets/images/mastercard.PNG';
    case 'visa electron': return 'assets/images/visaelectron.PNG';
    case 'maestro': return 'assets/images/maestro.PNG';
    case 'american express': return 'assets/images/americanexpress.PNG';
    case 'unionpay': return 'assets/images/unionpay.PNG';
    case 'diners club': return 'assets/images/dinersclub.PNG';
    case 'discover': return 'assets/images/discover.PNG';
    case 'jcb': return 'assets/images/jcb.PNG';
    case 'revolut': return 'assets/images/revolut.PNG';
    case 'n26': return 'assets/images/n26.PNG';
    case 'wise': return 'assets/images/wise.PNG';
    case 'carte e-dinar': return 'assets/images/edinar.PNG';
    case 'carte technologique': return 'assets/images/techno.PNG';
    case 'girocard': return 'assets/images/giro.PNG';
    case 'bancontact': return 'assets/images/bancontact.PNG';
    case 'payoneer': return 'assets/images/payonner.PNG';
    case 'skrill': return 'assets/images/skrill.PNG';
    case 'neteller': return 'assets/images/neteller.PNG';
    default: return 'assets/images/visa.PNG';
  }
}
