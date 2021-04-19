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
using System.Windows.Shapes;

namespace WpfApp1
{
    /// <summary>
    /// Interaction logic for Window1.xaml
    /// </summary>
    public partial class Window1 : Window
    {
        private BolnicaDataContext bolnica = new BolnicaDataContext();
        public Window1()
        {
            InitializeComponent();
        }
        private void resetuj()
        {
            txtIme.Text = "";
            txtPrezime.Text = "";
            txtPrt.Text = "";
            txtSifra.Text = "";
            txtSoba.Text = "";
            SldPrior.Value = 0;
            cmbOdelj.SelectedIndex = -1;
            cmbSoba.SelectedIndex = -1;
        }
        private void Button_Click(object sender, RoutedEventArgs e)
        {
            resetuj();
            this.Close();
        }

        private void SldPrior_ValueChanged(object sender, RoutedPropertyChangedEventArgs<double> e)
        {
            txtPrt.Text = SldPrior.Value.ToString();
        }
        private void puniKombo()
        {
            var odeljenja = bolnica.Odeljenjes;
            cmbOdelj.ItemsSource = odeljenja;
        }
        private void Window_Loaded(object sender, RoutedEventArgs e)
        {
            puniKombo();
        }

        private void BtnUnesi_Click(object sender, RoutedEventArgs e)
        {
            if (!String.IsNullOrEmpty(txtSifra.Text)&&!String.IsNullOrEmpty(txtIme.Text)&&!String.IsNullOrEmpty(txtPrezime.Text) && cmbOdelj.SelectedValue != null && cmbSoba.SelectedValue != null)
            {
                Pacijent pacijent = new Pacijent()
                {
                    IDPacijent = (int.Parse)(txtSifra.Text),
                    Ime = txtIme.Text,
                    Prezime = txtPrezime.Text,
                    Prioritet = (int.Parse)(txtPrt.Text),
                    OdeljenjeID = (int.Parse)(((Odeljenje)cmbOdelj.SelectedValue).OdeljenjeID.ToString()),
                    SobaID = (int.Parse)(((Soba)cmbSoba.SelectedValue).SobaID.ToString()),

                };
                bolnica.Pacijents.InsertOnSubmit(pacijent);

                try
                {
                    bolnica.SubmitChanges();
                    MessageBox.Show("Uspesan unos", "Obavestenje");
                }
                catch(Exception ex)
                {
                    MessageBox.Show("Nije dodata" + ex.Message);
                }
                //resetuj();
            }
            else
            {
                MessageBox.Show("Polja su prazna", "Obavestenje");
            }
        }
        private void poOdeljenju()
        {
            if (cmbOdelj.SelectedValue == null)
            {
                cmbOdelj.ItemsSource = null;
            }
            else
            {
                cmbSoba.ItemsSource = null;
                var odeljenje = int.Parse(((Odeljenje)cmbOdelj.SelectedValue).OdeljenjeID.ToString());
                var poOdeljenju = bolnica.Sobas.Where(x => x.OdeljenjeID == odeljenje);
                cmbSoba.ItemsSource = poOdeljenju;
            }
        }
        private void CmbOdelj_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
                poOdeljenju();
        }

        private void CmbSoba_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            if (cmbSoba.SelectedValue == null)
            {
                cmbSoba.ItemsSource = null;
                txtSoba.Text = "";
            }
            else
            {
                var soba = int.Parse(((Soba)cmbSoba.SelectedValue).SobaID.ToString());

                var sprat = bolnica.Sobas.Where(x => x.SobaID == soba).Select(x => x.Sprat).FirstOrDefault();
                txtSoba.Text = sprat.ToString();
            }
        }
    }
}
