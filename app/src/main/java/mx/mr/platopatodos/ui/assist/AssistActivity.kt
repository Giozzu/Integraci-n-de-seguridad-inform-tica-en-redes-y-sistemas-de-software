package mx.mr.platopatodos.ui.assist

import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import mx.mr.platopatodos.R
import mx.mr.platopatodos.databinding.ActivityAssistBinding

class AssistActivity : AppCompatActivity() {

    private lateinit var binding: ActivityAssistBinding

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        binding = ActivityAssistBinding.inflate(layoutInflater)
        setContentView(binding.root)
    }
}