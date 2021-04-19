using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Navigation;
using System.Windows.Shapes;

namespace WpfApp1
{
    /// <summary>
    /// Interaction logic for MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {
        private BolnicaDataContext bolnica = new BolnicaDataContext();
        public MainWindow()
        {
            InitializeComponent();
        }
        private void puniDatagrid()
        {

            var pacijenti = bolnica.Pacijents;
            dataGrid1.ItemsSource = pacijenti;
        }
        private void puniKombo()
        {
            var odeljenje = bolnica.Odeljenjes;
            var prioritet = bolnica.Pacijents.OrderBy(x=>x.Prioritet).Select(x=>x.Prioritet).Distinct();

            cmbPrioritet.ItemsSource =prioritet;
            cmbOdeljenje.ItemsSource=odeljenje;
        }
        private void PretragaOdeljenje()
        {
            var odeljenje = int.Parse(((Odeljenje)cmbOdeljenje.SelectedValue).OdeljenjeID.ToString());
            var poOdeljenju = bolnica.Pacijents.Where(x => x.OdeljenjeID == odeljenje);
            lbPacijent.ItemsSource = poOdeljenju;
        }
        private void PretragaPrioritet()
        {
            var prioritet = int.Parse(cmbPrioritet.SelectedValue.ToString());
            var poPrioritetu = bolnica.Pacijents.Where(x => x.Prioritet == prioritet && x.BrDana > 3);
            lbPacijent.ItemsSource = poPrioritetu;
        }
        private void maxDanaOdeljenje()
        {
            var odeljenje = int.Parse(((Odeljenje)cmbOdeljenje.SelectedValue).OdeljenjeID.ToString());
            int? max = bolnica.Pacijents.Where(x => x.OdeljenjeID == odeljenje).Max(x => x.BrDana);
            var maxdana = bolnica.Pacijents.Where(x => x.OdeljenjeID == odeljenje&&x.BrDana==max);
            lbPacijent.ItemsSource =maxdana;
        }
        private void MenuItem_Click(object sender, RoutedEventArgs e)
        {
            Window1 win = new Window1();
            win.ShowDialog();
        }
        private void Window_Loaded(object sender, RoutedEventArgs e)
        {
            puniDatagrid();
            puniKombo();
        }
        private void DataGrid1_LoadingRowDetails(object sender, DataGridRowDetailsEventArgs e)
        {
            int idpac = int.Parse(((Pacijent)dataGrid1.SelectedValue).IDPacijent.ToString());
            var pacijent=bolnica.Pacijents.Where(x=>x.IDPacijent==idpac).FirstOrDefault();

            if (pacijent != null)
            {
                TextBox tb1 = e.DetailsElement.FindName("idOdeljenje") as TextBox;
                tb1.Text = pacijent.OdeljenjeID.ToString();
                TextBox tb2 = e.DetailsElement.FindName("idSoba") as TextBox;
                tb2.Text = pacijent.SobaID.ToString();
                TextBox tb3 = e.DetailsElement.FindName("brDana") as TextBox;
                tb3.Text = pacijent.BrDana.ToString();
                txtBrDana.Text = pacijent.BrDana.ToString();
                txtSifraOtpust.Text = pacijent.IDPacijent.ToString();
            }
        }

        private void Button_Click(object sender, RoutedEventArgs e)
        {
            if (txtBrDana.Text.Length > 0 && txtPartic.Text.Length > 0)
            {
                txtCena.Text = (int.Parse(txtBrDana.Text) * int.Parse(txtPartic.Text)).ToString();
            }
            else
            {
                MessageBox.Show("Polje je prazno","Obavestenje");
            }

        }

        private void Button_Click_1(object sender, RoutedEventArgs e)
        {
            if (cmbOdeljenje.SelectedValue != null)
            {
                maxDanaOdeljenje();
            }

        }

        private void CmbPrioritet_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            Window window = Application.Current.MainWindow;
            lbPacijent.ItemTemplate = window.FindResource("pacijentPrioritet") as DataTemplate;

            if (cmbPrioritet.SelectedValue != null)
            {
                PretragaPrioritet();
            }
        }

        private void CmbOdeljenje_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            if (cmbOdeljenje.SelectedValue != null)
            {
                PretragaOdeljenje();
            }           
        }

        private void Button_Click_2(object sender, RoutedEventArgs e)
        {
            if (txtSifraOtpust.Text.Length > 0)
            {
                var sifraPacijent = int.Parse(txtSifraOtpust.Text);
                var otpust = bolnica.Pacijents.Where(x => x.IDPacijent == sifraPacijent).FirstOrDefault();

                MessageBoxResult result = MessageBox.Show("Da li ste sigurni?", "Brisanje", MessageBoxButton.YesNo);

                if (result == MessageBoxResult.Yes)
                {
                    bolnica.Pacijents.DeleteOnSubmit(otpust);
                    dataGrid1.ItemsSource = null;
                    puniDatagrid();
                    dataGrid1.Items.Refresh();
                    try
                    {
                        bolnica.SubmitChanges();
                        MessageBox.Show("Uspesno otpusten", "Obavestenje");
                       
                        
                    }
                    catch(Exception ex)
                    {
                        MessageBox.Show("Ne moze da se izbrise iz baze" + ex.Message);
                    }
                }
            }
            else
            {
                MessageBox.Show("Polje je prazno", "Obavestenje");
            }
        }

        private void DataGrid1_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            int idpac = int.Parse(((Pacijent)dataGrid1.SelectedValue).IDPacijent.ToString());
            var pacijent = bolnica.Pacijents.Where(x => x.IDPacijent == idpac).FirstOrDefault();

            if (pacijent != null)
            {
                txtBrDana.Text = pacijent.BrDana.ToString();
            }
        }
    }
}
